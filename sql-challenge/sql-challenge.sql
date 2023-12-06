--Create Tables
CREATE TABLE departments (
    dept_no VARCHAR NOT NULL,
    dept_name VARCHAR NOT NULL, 
	PRIMARY KEY (dept_no) 
);

CREATE TABLE dept_emp (
    emp_no BIGINT NOT NULL,
    dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager (
    dept_no VARCHAR NOT NULL,
    emp_no BIGINT NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE titles (
    title_id VARCHAR NOT NULL,
    title VARCHAR NOT NULL,
	PRIMARY KEY (title_id)
);

CREATE TABLE employees (
    emp_no BIGINT NOT NULL,
    title_id VARCHAR NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    sex VARCHAR NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY (emp_no),
	FOREIGN KEY (title_id) REFERENCES titles(title_id)
);

CREATE TABLE salaries (
    emp_no BIGINT NOT NULL,
    salary BIGINT NOT NULL
);
--

-- View Data
SELECT * FROM departments;

SELECT * FROM dept_emp;

SELECT * FROM dept_manager;

SELECT * FROM employees;

SELECT * FROM salaries;

SELECT * FROM titles;
--

-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT
    emp.emp_no,
    emp.last_name,
    emp.first_name,
    emp.sex,
    sal.salary
FROM
    employees emp
JOIN
    salaries sal ON emp.emp_no = sal.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT
    emp.first_name,
    emp.last_name,
    emp.hire_date
FROM
    employees emp
WHERE
    EXTRACT(YEAR FROM emp.hire_date) = 1986; -- https://www.sqltutorial.org/sql-date-functions/how-to-extract-year-from-date-in-sql/

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT
	manager.dept_no,
	dept.dept_name,
	manager.emp_no,
	emp.last_name,
    emp.first_name	
FROM
	dept_manager manager	
JOIN
	departments dept ON manager.dept_no = dept.dept_no
JOIN	
	employees emp ON manager.emp_no = emp.emp_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT
	dept_emp.dept_no,
	emp.emp_no,
	emp.last_name,
    emp.first_name,
	dept.dept_name
FROM
	employees emp
JOIN
	dept_emp dept_emp ON emp.emp_no = dept_emp.emp_no
JOIN	
	departments dept ON dept_emp.dept_no = dept.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT
	emp.first_name,
	emp.last_name,
	emp.sex
FROM
	employees emp
WHERE
	emp.first_name = 'Hercules'
AND
	LEFT(emp.last_name, 1) = 'B';

-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT
	emp.emp_no,
	emp.last_name,
    emp.first_name
FROM
	employees emp
JOIN
	dept_emp dept_emp ON emp.emp_no = dept_emp.emp_no
JOIN	
	departments dept ON dept_emp.dept_no = dept.dept_no
WHERE
	dept.dept_name = 'Sales'

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT
	emp.emp_no,
	emp.last_name,
    emp.first_name
FROM
	employees emp
JOIN
	dept_emp dept_emp ON emp.emp_no = dept_emp.emp_no
JOIN	
	departments dept ON dept_emp.dept_no = dept.dept_no
WHERE
	dept.dept_name IN ('Sales', 'Development');

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT
	last_name,
	COUNT(last_name)
	AS frequency
FROM
	employees
GROUP BY
	last_name
ORDER BY
	frequency DESC;