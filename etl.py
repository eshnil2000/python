#STEPS
#1. READ CSV, STORE INTO DATAFRAME
#2. CREATE NEW ROW IN DATAFRAME, WITH FIRST+LAST NAME
#3. CONNECT TO MYSQL
#4. CREATE DATABASE
#5. CREATE TABLE IN DATABASE WITH COLUMNS MATCHING THE DATAFRAME COLUMNS
#6. LOOP THROUGH DATAFRAME ROWS AND SAVE TO MYSQL BY CREATING QUERIES

import pandas as pd
import mysql.connector
from mysql.connector import Error

#FUNCTIONS 
def create_server_connection(host_name, user_name, user_password,db_name):
    connection = None
    try:
        #GET HANDLE TO THE MYSQL "DOOR"
        connection = mysql.connector.connect(
            host=host_name,
            user=user_name,
            passwd=user_password,
            database=db_name
        )
        print("MySQL Database connection successful")
    except Error as err:
        print(f"Error: '{err}'")
    #RETURN THE DOOR HANDLE
    return connection

def create_database(connection, query):
    cursor = connection.cursor()
    try:
        cursor.execute(query)
        print("Database created successfully")
    except Error as err:
        print(f"Error: '{err}'")
#THIS FUNCTION WILL RUN A QUERY TO MYSQL CONNECTION
def execute_query(connection, query):
    cursor = connection.cursor()
    try:
        cursor.execute(query)
        connection.commit()
        print("Query successful")
    except Error as err:
        print(f"Error: '{err}'")


#STEP 1 ====GET DATA FROM CSV INTO DATAFRAME===
data = pd.read_csv ('employees.csv') 
#data = pd.read_csv ('products.csv') 
df = pd.DataFrame(data)
df.apply(lambda s:s.replace("'", ""))

print(df.columns)
print('===')

#df['new_column'] = df['product_name'] + df['product_id'].astype(str)
##2. CREATE NEW ROW IN DATAFRAME, WITH FIRST+LAST NAME
# ====JOIN 2 COLUMNS, CREATE NEW COLUMN AND ADD TO DATAFRAME===
df['new_column'] = df['first_name'] + df['last_name']
#df['doj']= df['doj'].astype(str)
#df['dob']= df['dob'].astype(str)

print(df)
#====END OF CSV TO DATAFRAME===

#3. CONNECT TO MYSQL, SET VARIABLES TO PREPARE TO CONNECT OF MYSQL
ipaddress ="localhost"
username ="root"
password ="password"
dbname ="eshani"
port = 3306 #
table_name="products10"

#3. CONNECT TO MYSQL
connection = create_server_connection(ipaddress,username,password,dbname)

print(connection)
# set up the queries
# CREATE THE DATABASE, FORM THE QUERY STRING TO CREATE A NEW DATABASE
create_database_query="CREATE DATABASE eshani"
# CONNECT TO MYSQL USING THE QUERY STRING
status=create_database(connection,create_database_query)


#employee_id,first_name,last_name,manager_name,salary,age,doj,dob
#create the query string to create a new product table with name of the value of variable table_name
create_product_table_query = """
CREATE TABLE {table_name} (
  employee_id INT PRIMARY KEY,
  first_name VARCHAR(40) NOT NULL,
  last_name VARCHAR(40) NOT NULL,
  manager_name VARCHAR(40) NOT NULL,
  salary INT NOT NULL,
  age INT NOT NULL,
  doj VARCHAR(40) NOT NULL,
  dob VARCHAR(40) NOT NULL,
  new_column VARCHAR(40) NOT NULL
  );
 """.format(table_name=table_name)

#THIS ACTUALLY CONNECTS TO MYSQL WITH THE QUERY STRING
status= execute_query(connection,create_product_table_query)


populate_table = """
INSERT INTO {table_name} VALUES ({employee_id},{first_name},{last_name},{manager_name},{salary},{doj},{age},{dob},{new_column})
"""

for index, row in df.iterrows():
    populate_table_query= populate_table.format(table_name=table_name,employee_id=row['employee_id'],first_name=row['first_name'],last_name=row['last_name'],manager_name=row['manager_name'],salary=row['salary'],age=row['age'],doj=row['doj'],dob=row['dob'],new_column=row['new_column'])                                          
    print(populate_table_query)
    status= execute_query(connection,populate_table_query)
