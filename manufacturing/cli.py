import click
import itertools
from terminaltables import DoubleTable
from Manufacturer import *
from gui import *

@click.group()
@click.pass_context
def cli(ctx):
    """ IT9 Manufacturing Limited Internal System.
    
    \b
         ___ _____ ___  
        |_ _|_   _/ _ \ 
         | |  | || (_) |
         | |  | | \__, |
        |___| |_|   /_/ 
    """
    ctx.obj = Manufacturer()

@cli.command()
@click.option("--file", "-f", "input_filename", required=True, type=str)
@click.pass_context
def input(ctx, input_filename):
    """ Customer Request Input """
    ctx.obj.handle_inputfile(input_filename)
    click.echo("Successful request input")

@cli.command(short_help = "Inventory Monitoring")
@click.option("--print", "-p", "dump", is_flag=True)
@click.option("--output", "-o", "filename", default = "inventory.csv")
@click.pass_context
def inventory(ctx, dump, filename):
    """ Inventory Monitoring """
    data, columns = ctx.obj.inventory()
    if dump:
        # dump to terminal
        print (terminaltable(columns, data, title = "Inventory"))
    else:
        write_csv(filename, columns, data)

@cli.command()
@click.option("--customer", "-c", "customer_id", prompt=True, type=int)
def lookup(customer_id):
    results = query("Request_View", condition = "Customer_id = '%012d'" % customer_id, desc=True)
    print (terminaltable(results["columns"], results["rows"], title="Invoice Lookup"))

        
@cli.command(short_help = "History View")
@click.option("--type", "table", required=True, type=click.Choice(["Logistics_Request_View", "Logistics_Request", "Restock", "Production", "Consumption", "Recipe"]))
def history(table):
    """ Viewing record history """
    results = query(table, desc=True)
    print (terminaltable(results["columns"], results["rows"], title = table.capitalize()))

@cli.command(short_help = "GUI Mode")
@click.pass_context
def gui(ctx):
    GUI(ctx.obj, title="IT9 Manufacturing Ltd.", config_file = "config.ini")
