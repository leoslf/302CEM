from __future__ import print_function
import sys
import csv
from terminaltables import DoubleTable

def eprint(*argv, **kwargs):
    print (*argv, file=sys.stderr, **kwargs)

def write_csv(filename, fieldnames, rows):
    with open(filename, "w") as f:
        writer = csv.DictWriter(f, fieldnames)
        writer.writeheader()
        writer.writerows(rows)

def terminaltable(columns, data, title = None, cls = DoubleTable):
    table = cls([columns] + list(map(lambda row: row.values(), data)), title=title)
    return table.table
