DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;

CREATE TABLE Departments (
department_id INT,
department_name VARCHAR(100)
);

CREATE TABLE Location (
location_id INT,
location VARCHAR(30)
);

CREATE TABLE Employees (
employee_id INT,
employee_name VARCHAR(50),
gender ENUM('M','F'),
age INT,
hire_date DATE,
designation VARCHAR(100),
department_id INT,
location_id INT,
salary DECIMAL(10,2)
);
ALTER TABLE Employees ADD COLUMN email VARCHAR(100);
ALTER TABLE Employees MODIFY COLUMN designation VARCHAR(255);
ALTER TABLE Employees DROP COLUMN age;
ALTER TABLE Employees RENAME COLUMN hire_date TO date_of_joining;

RENAME TABLE Departments TO Departments_Info;
RENAME TABLE Location TO Locations;

TRUNCATE TABLE Employees;

DROP TABLE Employees;
DROP DATABASE employee;

DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;

CREATE TABLE Departments (
department_id INT PRIMARY KEY,
department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Location (
location_id INT PRIMARY KEY AUTO_INCREMENT,
location VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE Employees (
employee_id INT PRIMARY KEY,
employee_name VARCHAR(50) NOT NULL,
gender ENUM('M','F'),
age INT,
hire_date DATE DEFAULT (CURRENT_DATE),
designation VARCHAR(100),
department_id INT,
location_id INT,
salary DECIMAL(10,2),
CONSTRAINT chk_gender CHECK (gender IN ('M','F')),
CONSTRAINT chk_age CHECK (age >= 18),
CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES Departments(department_id),
CONSTRAINT fk_location FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

SELECT DISTINCT salary FROM Employees;
SELECT age AS Employee_Age, salary AS Employee_Salary FROM Employees;

SELECT * FROM Employees
WHERE salary > 50000 AND hire_date < '2016-01-01';

UPDATE Employees
SET designation = 'Data Scientist'
WHERE employee_id > 0
AND (designation IS NULL OR designation = '');
SELECT * FROM Employees
ORDER BY department_id ASC, salary DESC;

SELECT * FROM Employees
WHERE YEAR(hire_date) = 2018
ORDER BY hire_date
LIMIT 5;

SELECT SUM(e.salary) AS total_finance_salary
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

SELECT MIN(age) AS minimum_age FROM Employees;

SELECT l.location, MAX(e.salary) AS max_salary
FROM Employees e
JOIN Location l ON e.location_id = l.location_id
GROUP BY l.location;

SELECT designation, AVG(salary) AS avg_salary
FROM Employees
WHERE designation LIKE '%Analyst%'
GROUP BY designation;

SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS emp_count
FROM Departments d
LEFT JOIN Employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) < 3;

SELECT l.location, AVG(e.age) AS avg_age
FROM Employees e
JOIN Location l ON e.location_id = l.location_id
WHERE e.gender = 'F'
GROUP BY l.location
HAVING AVG(e.age) < 30;

SELECT e.employee_name, e.designation, d.department_name
FROM Employees e
INNER JOIN Departments d ON e.department_id = d.department_id;

SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS total_employees
FROM Departments d
LEFT JOIN Employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

SELECT l.location_id, l.location, e.employee_name
FROM Employees e
RIGHT JOIN Location l ON e.location_id = l.location_id;






