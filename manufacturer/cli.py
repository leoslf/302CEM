import click
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
@click.option("--output", "-o", "filename", default = "inventory.csv")
@click.option("--date", "-d", "date", default = None)
@click.pass_context
def inventory(ctx, *argv, **kwargs):
    ctx.obj.inventory_query(*argv, **kwargs)
