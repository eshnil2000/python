
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
