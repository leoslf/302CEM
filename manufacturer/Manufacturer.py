from __future__ import print_function
import sys
import os
import csv
import json
import datetime
from collections import OrderedDict

from db_connection import *

def eprint(*argv, **kwargs):
    print (*argv, file=sys.stderr, **kwargs)

STDIN_FILENO = 0
STDOUT_FILENO = 1
STDERR_FILENO = 2

class Manufacturer(object):
    """ Manufacturer Data Handling System
    """
    def __init__(self, *argv):
        _map = {
            "input": self.input,
            "inventory": self.inventory_query,
        }
        _map[argv[1]](*argv[2:])

    def input(self, *argv):
        if len(argv) < 1:
            eprint("USAGE: command input input.csv [input2.csv [input3.csv ...]]")
            sys.exit(2)

        input_filenames = argv[2:]
        for input_filename in input_filenames:
            self.handle_inputfile(input_filename)

    def handle_inputfile(self, input_filename):
        assert input_filename.endswith(".csv")
        with open(input_filename) as f:
            # reader = csv.reader(f)
            # table = [row for row in reader]
            # eprint(table)
            reader = csv.DictReader(f)
            table = list(reader)
        eprint(table)

        errmsg = []
        ids = []
        fieldnames = ["id"]
        try:
            for row in table:
                id = insert("Request", values = row, errmsg = errmsg)
                if id == -1:
                    raise RuntimeError("cannot insert row: %s" % row, "Error: %s" % ", ".join(map(str, errmsg)))
                ids.append({"id": id})
        finally:
            self.write_resultfile(input_filename, fieldnames, ids)
            self.write_request(input_filename, ids)


    def write_resultfile(self, input_filename, fieldnames, rows):
        output_filename = self.compose_filename(input_filename, "result")
        eprint("writing: %s" % output_filename)
        return self.write_csv(output_filename, fieldnames, rows)

    @classmethod
    def compose_filename(self, input_filename, insert_str):
        assert type(input_filename) == str
        tmp = input_filename.split(".")
        tmp.insert(-1, insert_str)
        return ".".join(tmp)

    @classmethod
    def write_csv(cls, filename, fieldnames, rows):
        with open(filename, "w") as f:
            writer = csv.DictWriter(f, fieldnames)
            writer.writeheader()
            writer.writerows(rows)

    @classmethod
    def dup2(cls, filename, fileno):
        """ syscall dup2

        Redirect fileno to filename
        
        :param filename: filename to be dup into fileno
        :param fileno: file descriptor number

        """
        new_stdout = os.open(filename, os.O_WRONLY | os.O_CREAT | os.O_TRUNC)
        os.dup2(new_stdout, fileno)

    def write_request(self, input_filename, request_ids):
        """ output request to logistics company

        :param request_ids: list of dictionaries containing the primary keys of different rows to be processed
        """
        dummy_PK = ""
        dummy_customer = query("Customer", condition = "id = '%s'" % dummy_PK)[0]
        # eprint(results)

        columns = ["quantity", "weight", "customer_id"]

        logistics_request_ids = []
        errmsg = []
        for row in request_ids:
            logistics_request_id = insert_by_query("Logistics_Request", columns, "SELECT SUM(r.qty), SUM(r.qty * p.weight), r.Customer_id FROM Request as r INNER JOIN Product AS p ON r.Product_id = p.id WHERE r.id = %d GROUP BY r.Product_id, r.Customer_id" % row["id"], errmsg = errmsg)
            if logistics_request_id < 1:
                raise RuntimeError("cannot insert row: %s" % row, "Error: %s" % ", ".join(map(str, errmsg)))
            logistics_request_ids.append(logistics_request_id)

        errmsg = []
        d = query("Logistics_Request_View", condition = " %s" % (" OR ".join(["id = %d" % id for id in logistics_request_ids])), desc=True, errmsg = errmsg)
        if d is None:
            raise RuntimeError("failed to query the list of requests, %s" % ", ".join(map(str, errmsg)))
        logistics_requests, fieldnames = d["rows"], d["columns"]

        pop_fields = ("id", "Customer_id")

        fieldnames = [col for col in fieldnames if col not in pop_fields]


        for row in logistics_requests:
            for pop_field in pop_fields:
                row.pop(pop_field, None)


        output_filename = self.compose_filename(input_filename, "output")
        return self.write_csv(output_filename, fieldnames, logistics_requests)

    def inventory(self, date = None):
        # Default Today
        if date is None:
            date = datetime.date.today().strftime("%Y-%m-%d")

        restocks = query("Restock", "Material_id, SUM(qty) AS qty", condition = "DATE(create_timestamp) < %s" % date, groupby = "Material_id")
        consumptions = query("Consumption", "Material_id, SUM(qty) AS qty", condition = "DATE(create_timestamp) < %s" % date, groupby = "Material_id")

        results = query("Material", "*, 0 AS qty", desc = True)
        materials, columns = results["rows"], results["columns"]
        for material in materials:
            id = material["id"]
            material["qty"] = restocks[id]["qty"] - consumptions[id]["qty"]

        return materials, columns
    
    def inventory_query(self, filename = "inventory.csv", date = None):
        debug("date: \"%r\"", date)
        inventory, columns = self.inventory(date)
        with open(filename, "w") as f:
            writer = csv.DictWriter(f, fieldnames = columns)
            
            writer.writeheader()
            writer.writerows(inventory)







        



        





            
