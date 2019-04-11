import csv
import pytest
import pymysql
import database_credential

from Manufacturer import *

credential_testing = dict(host="localhost", user="302CEM_Test", password="302CEM_Test", db="302CEM_Test")

def create_script():
    with open("dataformat.sql") as f:
        return f.read()

def test_createdb():
    credential = database_credential.db
    credential.update(credential_testing)
    assert all(credential[key] == credential_testing[key] for key in credential.keys())
    print (create_script())
    with pymysql.connect(**credential) as conn:
        with conn.cursor() as cursor:
            cursor.execute(create_script())
            cursor.execute("SHOW TABLES")
            for row in cursor.fetchall():
                print(row)
    assert False

def test_dropdb():
    # credential.pop("db")
    # conn = pymysql.connect(**credential)
    # with conn.cursor() as cursor:
    #     cursor.execute("DROP DATABASE %s" % testing_db)
    pass


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
