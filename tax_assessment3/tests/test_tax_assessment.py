import csv
import pytest

from tax_assessment import *

def cases():
    with open("tax_assessment_unittest.csv") as f:
        return list(csv.DictReader(f))

def intersect(a, b):
    keys = set(a.keys()) & set(b.keys())
    return {key: (a[key], b[key]) for key in keys}

@pytest.mark.parametrize("case", cases())
def test_run(case):
    case["marital_status"] = ["n", "y"].index(case["marital_status"][0].lower())
    result = tax_calculation(case)
    print (result)
    print ("Combined Tax: %d", (result["self_tax"] + result["spouse_tax"]))
    print ("case")
    print (case)

    print ("intersect: %r" % intersect(case, result))

    assert int(case["expected_tax"]) == ((result["combined_tax"] if result["combined"] else (result["self_tax"] + result["spouse_tax"])) if case["marital_status"] else result["self_tax"])

