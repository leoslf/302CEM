#!/usr/bin/env python
# -*- coding: UTF-8 -*-# enable debugging

import sys
from logging import *
import traceback
import operator
import database_credential
from collections import OrderedDict
import re
import pymysql
from pymysql.cursors import DictCursorMixin, Cursor

# basicConfig(level = DEBUG)
# basicConfig(level = INFO)

class OrderedDictCursor(DictCursorMixin, Cursor):
    dict_type = OrderedDict

def keyreduce(sequence, key):
    """ Get list of values from list of dictionaries by key """
    return list(map(operator.itemgetter(key), sequence))

class SQL_Condition(object):
    """ Binary Operator """
    def __init__(self, operands):
        self.operands = list(map(self.handle_operand, operands))

    def handle_operand(self, operand):
        return operand

    @property
    def separator(self):
        if type(self) == SQL_Condition:
            raise NotImplementedError("SQL_Condition must be subclassed")
        return " %s " % type(self).__name__

    def is_primitive(self, operand):
        return isinstance(operand, SQL_Condition)

    def parenthesize(self, operand):
        return "(%s)" % operand
    
    def __iter__(self):
        return iter([self])

    def __str__(self):
        return self.parenthesize(self.separator.join(map(str, self.operands)))

class AND(SQL_Condition):
    pass

class OR(SQL_Condition):
    pass

class REL(SQL_Condition):
    """ Relational Operator """
    def __init__(self, fmt, *argv, **kwargs):
        self.fmt = fmt
        super(REL, self).__init__(*argv, **kwargs)

    def handle_operand(self, operand):
        return self.fmt % operand

def database_connection(connection=None, autocommit=False):
    """get database connection"""
    if connection:
        return connection
    # TODO: reference to envvar

    return pymysql.connect(cursorclass=OrderedDictCursor, autocommit=autocommit, **database_credential.db)


def query(table,
          column="*",
          condition="",
          join="",
          desc=False,
          orderby=None,
          groupby="",
          join_type = "INNER",
          filter=None,
          err_msg=None,
          *argv,
          **kwargs):

    if groupby:
        groupby = " GROUP BY %s" % groupby

    sql = "SELECT %s FROM %s" % (column, table) \
            + (" %s JOIN %s" % (join_type, join) if join != "" else "") \
            + (" WHERE " + condition if condition != "" else "") \
            + (" ORDER BY " + orderby if orderby is not None else "") \
            + groupby 
    debug(sql)

    conn = database_connection()

    try:
        with conn.cursor() as cursor:
            cursor.execute(sql)

            #result = {"description" : cursor.description, "rows" : cursor.fetchall()}
            rows = cursor.fetchall()
            if filter is not None:
                rows = [item for item in rows \
                            if all(attrib not in item \
                                    or item[attrib] == filter[attrib]
                                for attrib in filter)]
            columns = list(zip(*cursor.description))[0]
            return rows if desc == False else OrderedDict([("rows", rows), ("description", cursor.description), ("columns", columns)])
    except:
        tb = traceback.format_exc()
        error("Exception: " + str(tb) + "<br />")
        if err_msg is not None:
            debug("err_msg is not None")
            assert (isinstance(err_msg, list))
            err_msg.append(tb)
            debug(err_msg)
    finally:
        conn.close()

    return None

def column_enum(table, column):
    sql = """
        SELECT COLUMN_TYPE 
        FROM information_schema.`COLUMNS` 
        WHERE TABLE_NAME = '%s' AND COLUMN_NAME = '%s'""" % (table, column)
    
    conn = database_connection()

    try:
        with conn.cursor() as cursor:
            cursor.execute(sql)

            rows = cursor.fetchone()
            assert (len(rows) == 1)
            debug(rows["COLUMN_TYPE"])
            values_str = re.search("\\(([^\\)]+)\\)", rows["COLUMN_TYPE"])
            values = values_str.group(1).split(",")
            values = [re.match("'([^']+)'", s).group(1) for s in values]
            return values

    except:
        tb = traceback.format_exc()
        error ("Exception: " + str(tb) + "<br />")
    finally:
        conn.close()

    return None
 
def insert(table,
           columns="",
           values="",
           errmsg=None,
           connection=None,
           select_stmt = None,
           *argv,
           **kwargs):

    if isinstance(values, dict):
        columns = "(%s)" % ", ".join(map(str, values.keys()))
        values = "(%s)" % ", ".join(["'%s'" % x for x in values.values()])

    elif columns != "" and (isinstance(values, str) or select_stmt is not None):
        # comma delimited string
        if isinstance(columns, list):
            columns = ", ".join(map(str, columns))
        columns = "(%s)" % columns

    elif isinstance(values, list):
        if type(values[0]) != list:
            values = [values]
        values = ", ".join(["(%s)" % ", ".join(map(str, ["'%s'" % x for x in row])) for row in values])
    else:
        if errmsg is not None and errmsg is list:
            errmsg.append("values provided is neither dictionary with columns nor string paired with columns nor list paired with columns")
        return -1

    source = select_stmt if select_stmt is not None else "VALUES %s" % values

    sql = "INSERT INTO %(table)s %(columns)s %(source)s" % {
                "table": table,
                "columns": columns,
                "source": source,
            }
    debug(sql)

    conn = database_connection(connection)

    assert conn is not None

    try:
        with conn.cursor() as cursor:
            cursor.execute(sql)
            return cursor.lastrowid
    except Exception as e:
        msg = "MYSQLError: errno %r, %r" % (e.args[0], e)
        if errmsg is not None:
            errmsg.append(msg)
        error(msg)
    finally:
        if connection is None:
            conn.commit()
            conn.close()

    return -1

def update(table,
           values,
           condition="",
           errmsg=None,
           connection=None,
           *argv,
           **kwargs):

    col_n_val = ", ".join(["%s = '%s'" % (column, values[column]) for column in values])

    sql = "UPDATE " + table \
            + " SET " + col_n_val \
            + ((" WHERE " + condition) if condition != "" else "")

    debug(sql)
    
    conn = database_connection(connection)

    try:
        with conn.cursor() as cursor:
            cursor.execute(sql)
            return cursor.rowcount
    except Exception as e:
        msg = "MYSQLError: errno %r, %r" % (e.args[0], e)
        if errmsg is not None:
            errmsg.append(msg)
        error(msg)
    finally:
        if connection is None:
            conn.commit()
            conn.close()

    return -1

def delete(table,
           condition="",
           errmsg=None,
           connection=None,
           *argv,
           **kwargs):
    
    sql = ("DELETE FROM " + table \
            + ((" WHERE " + condition) if condition != "" else ""))
    debug(sql)
    
    conn = database_connection(connection)

    try:
        with conn.cursor() as cursor:
            cursor.execute(sql)
            return cursor.rowcount
    except Exception as e:
        msg = "MYSQLError: errno %r, %r" % (e.args[0], e)
        if errmsg is not None:
            errmsg.append(msg)
        error(msg)
    finally:
        if connection is None:
            conn.commit()
            conn.close()

    return -1
