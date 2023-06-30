
create database if not exists sql_test;
show databases;
use sql_test;
drop table if exists employees;
CREATE TABLE employees (
    emp_no INT NOT NULL ,
    birth_date DATE NOT NULL,
    first_name VARCHAR(14) NOT NULL,
    last_name VARCHAR(16) NOT NULL,
    gender CHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY (emp_no)
);

INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
VALUES
    (1, '1990-01-01', 'John', 'Doe', 'M', '2020-01-01'),
    (2, '1992-03-15', 'Jane', 'Smith', 'F', '2021-02-05'),
    (3, '1985-07-10', 'Michael', 'Johnson', 'M', '2019-06-20'),
    (4, '1993-09-25', 'Emily', 'Williams', 'F', '2022-04-10'),
    (5, '1991-05-18', 'David', 'Brown', 'M', '2020-07-15'),
    (6, '1988-12-03', 'Jennifer', 'Davis', 'F', '2018-09-30'),
    (7, '1987-04-22', 'Daniel', 'Miller', 'M', '2021-03-12'),
    (8, '1994-08-12', 'Sophia', 'Anderson', 'F', '2022-08-05'),
    (9, '1996-06-08', 'Christopher', 'Wilson', 'M', '2019-11-21'),
    (10, '1989-11-11', 'Olivia', 'Taylor', 'F', '2020-02-18'),
    (11, '1997-02-28', 'Matthew', 'Martinez', 'M', '2022-05-05'),
    (12, '1995-10-07', 'Emma', 'Clark', 'F', '2018-08-10'),
    (13, '1992-01-14', 'Andrew', 'Lee', 'M', '2021-01-30'),
    (14, '1986-03-29', 'Isabella', 'Walker', 'F', '2019-04-25'),
    (15, '1993-07-06', 'James', 'Hall', 'M', '2022-06-01'),
    (16, '1991-04-17', 'Ava', 'Allen', 'F', '2020-09-20'),
    (17, '1988-08-24', 'Alexander', 'Young', 'M', '2018-12-15'),
    (18, '1995-12-31', 'Mia', 'King', 'F', '2022-02-28'),
    (19, '1990-06-16', 'Benjamin', 'Wright', 'M', '2020-05-10'),
    (20, '1987-09-09', 'Charlotte', 'Lopez', 'F', '2019-07-05');

INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
VALUES
    (21, '1966-01-01', 'John', 'Doe', 'M', '1985-01-01'),
    (22, '1965-03-15', 'Jane', 'Smith', 'F', '1986-02-05'),
    (23, '1955-07-10', 'Michael', 'Johnson', 'M', '1985-06-20'),
    (24, '1966-09-25', 'Emily', 'Williams', 'F', '1986-04-10');

    select * from employees;

    CREATE TABLE if not exists departments (
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE (dept_name)
);

INSERT INTO departments (dept_no, dept_name)
VALUES
    ('D001', 'Sales'),
    ('D002', 'Marketing'),
    ('D003', 'Finance'),
    ('D004', 'Human Resources'),
    ('D005', 'Research and Development');


CREATE TABLE if not exists dept_manager (
    emp_no INT NOT NULL,
    dept_no CHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no) ON DELETE CASCADE,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no, dept_no)
);

CREATE INDEX idx_dept_manager_emp_no ON dept_manager (emp_no);
CREATE INDEX idx_dept_manager_dept_no ON dept_manager (dept_no);

INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date)
VALUES
    (1, 'D001', '1994-01-01', '2022-12-31'),
    (19, 'D002', '1996-05-15', '2023-02-28'),
    (3, 'D003', '2000-07-01', '2024-06-30'),
    (6, 'D004', '2018-09-01', '2023-08-31'),
    (12, 'D005', '1992-03-01', '2023-12-31'),
    (14, 'D001', '2021-01-01', '2023-12-31');

CREATE TABLE if not exists title (
  title_id INT PRIMARY KEY,
  title_name VARCHAR(255)
);

INSERT INTO title (title_id, title_name)
VALUES
  (1, 'Title 1'),
  (2, 'Title 2'),
  (3, 'Title 3'),
  (4, 'Title 4'),
  (5, 'Title 5'),
  (6, 'Title 6'),
  (7, 'Title 7'),
  (8, 'Title 8'),
  (9, 'Title 9'),
  (10, 'Title 10');

SELECT d.dept_name, COUNT(de.emp_no) AS num_employees, SUM(s.salary) AS total_salary
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON de.emp_no = s.emp_no
WHERE de.to_date = '9999-01-01' -- Assuming '9999-01-01' represents the current date in the database
GROUP BY d.dept_name
ORDER BY total_salary DESC;

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no CHAR(4) NOT NULL
);
CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

INSERT INTO salaries (emp_no, salary)
VALUES
    (1, 50000),
    (2, 60000),
    (3, 55000),
    (4, 65000),
    (5, 70000),
    (6, 52000),
    (7, 58000),
    (8, 63000),
    (9, 67000),
    (10, 54000),
    (11, 62000),
    (12, 56000),
    (13, 59000),
    (14, 68000),
    (15, 57000),
    (16, 53000),
    (17, 64000),
    (18, 61000),
    (19, 66000),
    (20, 59000),
    (21, 55000),
    (22, 61000),
    (23, 60000),
    (24, 62000);



INSERT INTO dept_emp (emp_no, dept_no)
VALUES
    (1, 'D001'),
    (2, 'D002'),
    (3, 'D003'),
    (4, 'D004'),
    (5, 'D005'),
    (6, 'D001'),
    (7, 'D002'),
    (8, 'D003'),
    (9, 'D004'),
    (10, 'D005'),
    (11, 'D001'),
    (12, 'D002'),
    (13, 'D003'),
    (14, 'D004'),
    (15, 'D005'),
    (16, 'D001'),
    (17, 'D002'),
    (18, 'D003'),
    (19, 'D004'),
    (20, 'D005'),
    (21, 'D001'),
    (22, 'D002'),
    (23, 'D003'),
    (24, 'D004');

