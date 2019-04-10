# -*- coding: UTF-8 -*-# enable debugging
import sys
import os
import csv
import json
import datetime

from collections import OrderedDict

from db_connection import *
from utils import *

class Manufacturer(object):
    """ Manufacturer Data Handling System """
    
    def handle_inputfile(self, input_filename):
        assert input_filename.endswith(".csv")
        with open(input_filename) as f:
            reader = csv.DictReader(f)
            table = list(reader)

        # eprint(table)

        errmsg = []
        request_ids = []
        fieldnames = ["id"]

        connection = database_connection()
        try:
            for row in table:
                id = insert("Request", values = row, errmsg = errmsg, connection = connection)
                if id == -1:
                    raise RuntimeError("cannot insert row: %s" % row, "Error: %s" % ", ".join(map(str, errmsg)))
                request_ids.append({"id": id})

            connection.commit()
        finally:
            connection.close()

        # Produce each request
        for request in request_ids:
            request = query("Request", condition = "id = %d" % request["id"])[0]
            product_id, qty = request["Product_id"], int(request["qty"])
            self.produce(product_id, qty, request["id"])

        self.write_resultfile(input_filename, fieldnames, request_ids)
        self.write_request(input_filename, request_ids)

    def produce(self, product_id, qty, request_id):
        info("Producing product: (id: %s) x %d", product_id, qty)

        # check inventory
        inventory, _ = self.inventory()
        recipe = self.product_recipe(product_id, qty)
        debug(recipe)

        required_materials = list(filter(lambda row: row["id"] in recipe.keys(), inventory))

        # check if there are materials out of stock
        for material in required_materials:
            material_id = int(material["id"])

            # Restock if not enough
            material_qty = material["qty"]
            material_qty -= recipe[material_id]
            if material_qty < 0:
                self.restock(material_id, -material_qty)

        connection = database_connection()


        production_id = insert("Production", values = {"Product_id": product_id, "qty": qty, "Request_id": request_id}, connection = connection)
        if production_id < 0:
            raise RuntimeError("Failed to insert product (id: %s) with qty %d" % (product_id, qty))

        for material_id, qty in recipe.items():
            rc = insert("Consumption", values = {"Production_id": production_id, "Material_id": material_id, "qty": qty}, connection = connection)
            if rc < 0:
                raise RuntimeError("Failed to insert consumption (product_id: %s, material_id: %d) with qty %d" % (product_id, material_id, qty))

        connection.commit()
        connection.close()



    def product_recipe(self, product_id, qty = 1):
        results = query("Recipe", condition = "Product_id = '%s'" % product_id)
        return {row["Material_id"]: row["qty"] * qty for row in results}


    def restock(self, material_id, qty, buffer_qty = 100):
        info("Restock: material %d", material_id)
        errmsg = []
        rc = insert("Restock", values = {"Material_id": material_id, "qty": qty + buffer_qty}, errmsg = errmsg)
        if rc < 0:
            raise RuntimeError("Failed to restock material (id: %d), errmsg: %s", material_id, ", ".join(map(str, errmsg)))


    def write_resultfile(self, input_filename, fieldnames, rows):
        output_filename = self.compose_filename(input_filename, "result")
        info("writing: %s", output_filename)
        return write_csv(output_filename, fieldnames, rows)

    @classmethod
    def compose_filename(self, input_filename, insert_str):
        tmp = input_filename.split(".")
        tmp.insert(-1, insert_str)
        return ".".join(tmp)

    def write_request(self, input_filename, request_ids):
        """ output request to logistics company

        :param request_ids: list of dictionaries containing the primary keys of different rows to be processed
        """
        columns = ["quantity", "weight", "customer_id"]

        errmsg = []

        connection = database_connection()

        # NOTE: Safely assume that there should only be a single customer id
        logistics_request_id = insert("Logistics_Request", columns, select_stmt = (
            "SELECT SUM(r.qty), SUM(r.qty * p.weight), r.Customer_id "
            "FROM Request as r "
            "INNER JOIN Product AS p ON r.Product_id = p.id "
            "WHERE %s GROUP BY r.Customer_id") % OR(REL("r.id = %d", keyreduce(request_ids, "id"))), errmsg = errmsg, connection = connection)

        if logistics_request_id < 1:
            raise RuntimeError("cannot insert row: %s" % row, "Error: %s" % ", ".join(map(str, errmsg)))

        for request_id in keyreduce(request_ids, "id"):
            value = {"Logistics_Request_id": logistics_request_id, "Request_id": request_id}
            rel_id = insert("Logistics_Request_Request", values = value, errmsg = errmsg, connection = connection)
            if rel_id < 0:
                raise RuntimeError("Cannot insert relation: %r, errmsg: %s" % (value, ";".join(map(str, errmsg))))

        connection.commit()
        connection.close()

        d = query("Logistics_Request_View", condition = "id = %d" % logistics_request_id, desc=True, errmsg=errmsg)
        if d is None:
            raise RuntimeError("failed to query the list of requests, %s" % ", ".join(map(str, errmsg)))
        logistics_requests, fieldnames = d["rows"], d["columns"]

        pop_fields = ("id", "Customer_id")

        fieldnames = [col for col in fieldnames if col not in pop_fields]

        for row in logistics_requests:
            for pop_field in pop_fields:
                row.pop(pop_field, None)

        output_filename = self.compose_filename(input_filename, "output")
        return write_csv(output_filename, fieldnames, logistics_requests)

    def inventory(self, date = None):
        # Default Today
        if date is None:
            date = datetime.date.today().strftime("%Y-%m-%d")

        restocks = query("Material AS m", "m.id AS Material_id, COALESCE(SUM(r.qty), 0) AS qty", join = "(SELECT * FROM Restock WHERE DATE(create_timestamp) <= '%s') AS r ON r.Material_id = m.id" % date, groupby = "m.id", join_type = "LEFT")
        consumptions = query("Material AS m", "m.id AS Material_id, COALESCE(SUM(c.qty), 0) AS qty", join = "(SELECT * FROM Consumption WHERE DATE(create_timestamp) <= '%s') AS c ON c.Material_id = m.id" % date,  groupby = "m.id", join_type = "LEFT")

        results = query("Material", "*, 0 AS qty", desc = True)
        materials, columns = results["rows"], results["columns"]
        for material in materials:
            id = material["id"]
            restock_row = filter(lambda row: row["Material_id"] == id, restocks)[0]
            consumption_row = filter(lambda row: row["Material_id"] == id, consumptions)[0]
            material["qty"] = restock_row["qty"] - consumption_row["qty"]

        return materials, columns
    
