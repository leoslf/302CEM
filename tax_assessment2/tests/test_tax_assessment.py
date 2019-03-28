import csv
import pytest

from tax_assessment import *

def cases():
    with open("tax_assessment_unittest.csv") as f:
        return list(csv.DictReader(f))

@pytest.mark.parametrize("case", cases())
def test_run(case):
    case["marital_status"] = ["n", "y"].index(case["marital_status"].lower())
    result = tax_calculation(case)
    print (result)
    print ("Combined Tax: %d", (result["self_tax"] + result["spouse_tax"]))
    print ("case")
    print (case)
    assert int(case["expected_tax"]) == (result["combined_tax"] if result["combined"] else (result["self_tax"] + result["spouse_tax"]))

