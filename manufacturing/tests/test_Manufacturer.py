# -*- coding: UTF-8 -*-# enable debugging
import csv
import pytest
import pymysql
import database_credential
import operator

from Manufacturer import *
from db_connection import OrderedDictCursor

credential_testing = dict(host="localhost", user="302CEM_Test", password="302CEM_Test", db="302CEM_Test")

expected_tables = [
    'Consumption',
    'Customer',
    'Logistics',
    'Logistics_Request',
    'Logistics_Request_Request',
    'Material',
    'Product',
    'Production',
    'Recipe',
    'Request',
    'Restock',
    'Restock_View',
    'Request_View',
    'Inventory',
    'Consumption_View',
    'Logistics_Request_View',
]


@pytest.fixture
def create_script():
    with open("dataformat.sql") as f:
        return f.read()

@pytest.fixture
def insert_script():
    with open("data.sql") as f:
        return f.read()

def test_setupdb(create_script, insert_script):
    credential = database_credential.db
    credential.update(credential_testing)
    assert all(credential[key] == credential_testing[key] for key in credential.keys())

    conn = pymysql.connect(**credential)
    with conn.cursor() as cursor:
        cursor.mogrify(create_script)
    conn.commit()
    conn.close()

    conn = pymysql.connect(**credential)
    with conn.cursor() as cursor:
        cursor.execute("SHOW TABLES")
        actual_tables = cursor.fetchall()
        print (set(expected_tables))
        actual_tables = list(map(operator.itemgetter(0), actual_tables))
        print (set(actual_tables))
        assert set(map(lambda s: s.lower(), actual_tables)) == set(map(lambda s: s.lower(), expected_tables))

    with conn.cursor() as cursor:
        cursor.execute("SHOW FULL TABLES WHERE Table_Type != 'VIEW'")
        for table in map(operator.itemgetter(0), cursor.fetchall()):
            cursor.execute("DELETE FROM %s" % table)
    conn.commit()
    
    with conn.cursor() as cursor:
        cursor.mogrify(insert_script)
        
    conn.commit()
    conn.close()


# def cases():
#     with open("tax_assessment_unittest.csv") as f:
#         return list(csv.DictReader(f))
# 
# @pytest.mark.parametrize("case", cases())
# def test_run(case):
#     case["marital_status"] = ["n", "y"].index(case["marital_status"].lower())
#     result = tax_calculation(case)
#     print (result)
#     print ("Combined Tax: %d", (result["self_tax"] + result["spouse_tax"]))
#     print ("case")
#     print (case)
#     assert int(case["expected_tax"]) == (result["combined_tax"] if result["combined"] else (result["self_tax"] + result["spouse_tax"]))
# 
