from __future__ import print_function
import sys
import os
import csv
import json
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
        if len(sys.argv) < 2:
            eprint("USAGE: command input.csv [output.csv]")
            sys.exit(2)

        input_filenames = argv[1:]
        for input_filename in input_filenames:
            self.handle_inputfile(input_filename)

        # if len(argv) > 2:
        #     output_filename = argv[2]
        #     assert output_filename.endswith(".csv")
        #     # redirect stdout to output_filename
        #     new_stdout = os.open(output_filename, os.O_WRONLY|os.O_CREAT|os.O_TRUNC)
        #     os.dup2(new_stdout, STDOUT_FILENO)

        

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
        try:
            for row in table:
                id = insert("Request", values = row, errmsg = errmsg)
                if id == -1:
                    raise RuntimeError("cannot insert row: %s" % row, "Error: %s" % ", ".join(map(str, errmsg)))
                ids.append({"id": id})
        finally:
            self.write_resultfile(input_filename, ids)

    def write_resultfile(self, input_filename, ids):
        tmp = input_filename.split(".")
        eprint(tmp)
        tmp.insert(-1, "_result")
        eprint(tmp)
        output_filename = ".".join(tmp)
        eprint(output_filename)
        assert output_filename.endswith(".csv")
        # redirect stdout to output_filename
        new_stdout = os.open(output_filename, os.O_WRONLY | os.O_CREAT | os.O_TRUNC)
        os.dup2(new_stdout, STDOUT_FILENO)

            
