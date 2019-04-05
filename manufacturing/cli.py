import click
import itertools
from terminaltables import DoubleTable
from Manufacturer import *

@click.group()
@click.pass_context
def cli(ctx):
    ctx.obj = Manufacturer()

@cli.command()
@click.option("--file", "-f", required=True, type=str)
def input(ctx, *argv, **kwargs):
    ctx.obj.handle_inputfile(*argv, **kwargs)

@cli.command()
@click.option("--date", "-d", "date", default = None)
@click.option("--print", "-p", "dump", is_flag=True)
@click.option("--output", "-o", "filename", default = "inventory.csv")
@click.pass_context
def inventory(ctx, date, dump, filename):
    data, columns = ctx.obj.inventory(date)
    if dump:
        # dump to terminal
        print (terminaltable(columns, data, title = "Inventory"))
    else:
        write_csv(filename, columns, data)
        
        
