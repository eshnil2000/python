import pandas as pd
import psycopg2

# Read CSV file
csv_file_path = "path_to_csv_file.csv"
csv_data = pd.read_csv(csv_file_path)

# Generate department CSV if not already generated
dept_csv_path = "path_to_department_csv.csv"
if not pd.DataFrame(columns=["deptId", "deptName"]).equals(csv_data[["deptId", "deptName"]]):
    dept_data = csv_data[["deptId", "deptName"]]
    dept_data.drop_duplicates(inplace=True)
    dept_data.to_csv(dept_csv_path, index=False)

# Connect to PostgreSQL
conn = psycopg2.connect(
    host="your_host",
    database="your_database",
    user="your_username",
    password="your_password"
)

# Read employee table from PostgreSQL
query = "SELECT empId, empName, Salary, deptId FROM employee"
employee_data = pd.read_sql(query, conn)

# Lookup department names from CSV
dept_data = pd.read_csv(dept_csv_path)
employee_data = pd.merge(employee_data, dept_data, on="deptId")

# Find second highest salary for each department
result = employee_data.groupby("deptName").apply(lambda x: x.nlargest(2, "Salary")).reset_index(drop=True)

# Print the result
print(result[["empId", "empName", "Salary", "deptName"]])
