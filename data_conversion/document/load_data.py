import pymongo
import pyodbc
from decimal import Decimal
from bson.decimal128 import Decimal128

def convert_decimal(dict_item):
    # This function iterates a dictionary looking for types of Decimal and converts them to Decimal128
    # Embedded dictionaries and lists are called recursively.
    # Source: https://stackoverflow.com/questions/61456784/pymongo-cannot-encode-object-of-type-decimal-decimal
    # Thanks Belly Buster
    if dict_item is None: return None

    for k, v in list(dict_item.items()):
        if isinstance(v, dict):
            convert_decimal(v)
        elif isinstance(v, list):
            for l in v:
                convert_decimal(l)
        elif isinstance(v, Decimal):
            dict_item[k] = Decimal128(str(v))

    return dict_item

def connect_to_mongo():
    CONNECTION_STRING = ""

    from pymongo import MongoClient
    client = MongoClient(CONNECTION_STRING)
    
    return client['AdventureWorksDocument']

def connect_to_sql():
    server = 'tcp:deckard' 
    database = 'AdventureWorks2019' 
    username = 'sa' 
    password = 'DS785password' 
    return pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)

cnxn = connect_to_sql()
cursor = cnxn.cursor()

order_fields = [
    'SalesOrderId',
    'OrderDate',
    'DueDate',
    'ShipDate',
    'SalesOrderNumber',
    'PurchaseOrderNumber',
    'AccountNumber',
    'CustomerID',
    'TerritoryID',
    'ShipToAddressID',
    'SubTotal',
    'TaxAmt',
    'Freight',
    'TotalDue'
]

order_select_statement = "SELECT {} FROM Sales.SalesOrderHeader WHERE OnlineOrderFlag = 1;".format(','.join(order_fields))
cursor.execute(order_select_statement)
orders = [{header: value for header, value in zip(order_fields, row)} for row in cursor.fetchall()]
print(orders[0])

# Get customer details
customer_fields = ['CustomerID', 'PersonID', 'FirstName', 'LastName', 'EmailAddress']
customer_select_statement = "SELECT {} FROM Sales.Customer cust JOIN Person.Person per ON per.BusinessEntityID = cust.PersonID JOIN Person.EmailAddress email ON email.BusinessEntityID = per.BusinessEntityID;".format(','.join(customer_fields))
cursor.execute(customer_select_statement)
customers = {row[0]: {header: value for header, value in zip(customer_fields, row)} for row in cursor.fetchall()}
print(customers[29485])

# Get Territory details
territory_fields = ['TerritoryID', '[Name]', 'CountryRegionCode', '[Group]']
territory_select_statement = "SELECT {} FROM Sales.SalesTerritory;".format(','.join(territory_fields))
cursor.execute(territory_select_statement)
territories = {row[0]: {header.replace('[', '').replace(']', ''): value for header, value in zip(territory_fields, row)} for row in cursor.fetchall()}

# Get ship to address details-
address_fields = ['addr.AddressID', 'addr.AddressLine1', 'addr.AddressLine2', 'addr.City', 'sp.StateProvinceCode', 'sp.CountryRegionCode', 'addr.PostalCode']
address_select_statement = "SELECT {} FROM Person.Address addr JOIN Person.StateProvince sp ON sp.StateProvinceID = addr.StateProvinceID;".format(','.join(address_fields))
cursor.execute(address_select_statement)
addresses = {row[0]: {header: value for header, value in zip(address_fields, row)} for row in cursor.fetchall()}

cnxn.close()

# Update order information
for order in orders:
    order['Customer'] = customers[order.pop('CustomerID')]
    order['Territory'] = territories[order.pop('TerritoryID')]
    order['ShipToAddress'] = addresses[order.pop('ShipToAddressID')]

    order = convert_decimal(order)

mongo = connect_to_mongo()

mongo['orders'].delete_many({})

mongo['orders'].insert_many(orders)