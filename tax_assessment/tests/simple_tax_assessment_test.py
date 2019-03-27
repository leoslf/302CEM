# -*- coding: utf-8 -*-
from __future__ import print_function

import sys
import os

import csv
import pytest
import jsonlines 
import multiprocessing
import pipes

from subprocess import Popen, PIPE, STDOUT

from simple_tax_assessment import *

# @pytest.fixture
def cases():
    with open("tax_assessment_unittest.csv") as f:
        return list(csv.DictReader(f))
    # with jsonlines.open("input.jsonl") as reader:
    #     return list(reader)

@pytest.mark.parametrize("case", cases())
def test_run(case):
    eprint("Case: %s" % case["Case"])

    eprint("case object: \"%r\"" % case)

    input_string = "\n".join(map(str, map(lambda key: case[key], ["self_income", "marital_status", "spouse_income"]))) + "\n"
    eprint("input_string: \"%s\"" % input_string)
    expected_tax = int(case["expected_tax"])

    p = Popen(["python", "simple_tax_assessment.py"], stdin=PIPE, stdout=PIPE, stderr=PIPE)
    stdout, stderr = p.communicate(input=input_string)


    eprint("stderr:\n\"%s\"" % stderr)
    eprint ("stdout: %s" % stdout)

    actual_tax = int(stdout)

    eprint("actual_tax: %d" % actual_tax)

    assert expected_tax == actual_tax

    p.wait()
    assert p.returncode == 0


        

