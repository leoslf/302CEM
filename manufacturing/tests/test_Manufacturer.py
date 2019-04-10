import csv
import pytest
import pymysql
import database_credential

from Manufacturer import *

testing_db = "302CEM_Test"
credential = database_credential.db

def test_createdb():
    credential.pop("db")
    conn = pymysql.connect(**credential)
    with conn.cursor() as cursor:
        cursor.execute("DROP DATABASE IF EXISTS %s" % testing_db)
        cursor.execute("CREATE DATABASE %s" % testing_db)
        cursor.execute("SHOW DATABASES")
        for row in cursor.fetchall():
            print(row)
    conn.commit()
    conn.close()
    credential["db"] = testing_db
    assert False

def test_dropdb():
    credential.pop("db")
    conn = pymysql.connect(**credential)
    with conn.cursor() as cursor:
        cursor.execute("DROP DATABASE %s" % testing_db)


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
