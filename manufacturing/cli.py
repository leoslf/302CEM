import click
import itertools
from terminaltables import DoubleTable
from Manufacturer import *

@click.group()
@click.pass_context
def cli(ctx):
    """ IT9 Manufacturing Company Internal System.
    
    \b
    ### #######  #####  
     #     #    #     # 
     #     #    #     # 
     #     #     ###### 
     #     #          # 
     #     #    #     # 
    ###    #     #####  
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
@click.option("--date", "-d", "date", default = None)
@click.option("--print", "-p", "dump", is_flag=True)
@click.option("--output", "-o", "filename", default = "inventory.csv")
@click.pass_context
def inventory(ctx, date, dump, filename):
    """ Inventory Monitoring """
    data, columns = ctx.obj.inventory(date)
    if dump:
        # dump to terminal
        print (terminaltable(columns, data, title = "Inventory"))
    else:
        write_csv(filename, columns, data)
        
@cli.command(short_help = "History View")
@click.option("--type", "table", required=True, type=click.Choice(["Logistics_Request_View", "Logistics_Request", "Restock", "Production", "Consumption", "Recipe"]))
def history(table):
    """ Viewing record history """
    results = query(table, desc=True)
    print (terminaltable(results["columns"], results["rows"], title = table.capitalize()))
