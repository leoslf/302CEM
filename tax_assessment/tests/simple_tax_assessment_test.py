from __future__ import print_function

import sys
import os

import pytest
import jsonlines 
import multiprocessing
import pipes

from subprocess import Popen, PIPE, STDOUT

from simple_tax_assessment import *

@pytest.fixture
def cases():
    with jsonlines.open("input.jsonl") as reader:
        return list(reader)

def test_run(cases):
    for case in cases:
        input_string = "\n".join(map(str, map(lambda key: case[key], ["self_income", "marital_status", "spouse_income"]))) + "\n"
        eprint(input_string)
        expected_tax = int(case["expected_tax"])

        p = Popen(["python", "simple_tax_assessment.py"], stdin=PIPE, stdout=PIPE, stderr=PIPE)
        stdout, stderr = p.communicate(input=input_string)
        eprint (stderr)

        eprint ("stdout: %s" % stdout)
        actual_tax = int(stdout)

        assert expected_tax == actual_tax

        

