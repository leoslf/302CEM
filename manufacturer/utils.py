from __future__ import print_function
from terminaltables import DoubleTable

def eprint(*argv, **kwargs):
    print (*argv, file=sys.stderr, **kwargs)

def write_csv(filename, columns, data):
    with open(filename, "w") as f:
        writer = csv.DictWriter(f, fieldnames = columns)
        
        writer.writeheader()
        writer.writerows(data)

def terminaltable(columns, data, title = None, cls = DoubleTable):
    table = DoubleTable([columns] + list(map(lambda row: row.values(), data)), title=title)
    return table.table
