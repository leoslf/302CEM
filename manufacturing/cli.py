import click
import itertools
from terminaltables import DoubleTable
from Manufacturer import *

@click.group()
@click.pass_context
def cli(ctx):
    ctx.obj = Manufacturer()

@cli.command()
@click.option("--file", "-f", "input_filename", required=True, type=str)
@click.pass_context
def input(ctx, input_filename):
    ctx.obj.handle_inputfile(input_filename)
    click.echo("Successful request input")

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
        
@cli.command()
@click.option("--type", "table", required=True, type=click.Choice(["Logistics_Request_View", "Logistics_Request", "Restock", "Production", "Consumption", "Recipe"]))
def history(table):
    results = query(table, desc=True)
    print (terminaltable(results["columns"], results["rows"], title = table.capitalize()))
