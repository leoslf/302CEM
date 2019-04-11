# -*- coding: UTF-8 -*-# enable debugging
import csv
import pytest
import pymysql
import database_credential

from Manufacturer import *
from db_connection import OrderedDictCursor

credential_testing = dict(host="localhost", user="302CEM_Test", password="302CEM_Test", db="302CEM_Test")

expected_tables = [
    ('Consumption',),
    ('Consumption_View',),
    ('Customer',),
    ('Inventory',),
    ('Logistics',),
    ('Logistics_Request',),
    ('Logistics_Request_Request',),
    ('Logistics_Request_View',),
    ('Material',),
    ('Product',),
    ('Production',),
    ('Recipe',),
    ('Request',),
    ('Request_View',),
    ('Restock',),
    ('Restock_View',)
]

@pytest.fixture
def create_script():
    with open("dataformat.sql") as f:
        return f.read()

def test_setupdb(create_script):
    credential = database_credential.db
    credential.update(credential_testing)
    assert all(credential[key] == credential_testing[key] for key in credential.keys())
    conn = pymysql.connect(**credential)
    with conn.cursor() as cursor:
        cursor.mogrify(create_script)
        cursor.execute("SHOW TABLES")
        actual_tables = list(cursor.fetchall())
        assert actual_tables == expected_tables
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
