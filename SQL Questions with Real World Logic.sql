-- SQL Assignment: Practical SQL with Real-World Logic

-- Topics Covered:
-- ---------------
-- * UPDATE, DELETE, TRUNCATE, ALTER
-- * DISTINCT, LIKE
-- * Aggregate Functions (SUM, AVG, COUNT, MIN, MAX)
-- * GROUP BY, HAVING
-- * ORDER BY
-- * LIMIT, OFFSET
-- * Alias

# Table Creation
-- -----------------
CREATE TABLE employees1 (
 emp_id INT PRIMARY KEY,
 name VARCHAR(50),
 age INT,
 department VARCHAR(50),
 salary INT,
 city VARCHAR(50),
 join_date DATE
);


### Sample Data 
-- ----------------
INSERT INTO employees1 VALUES
(1,'Amit',25,'HR',30000,'Pune','2022-01-10'),
(2,'Neha',30,'IT',60000,'Mumbai','2021-03-15'),
(3,'Raj',28,'Finance',50000,'Delhi','2020-07-20'),
(4,'Priya',35,'IT',70000,'Pune','2019-11-01'),
(5,'Karan',40,'HR',45000,'Bangalore','2018-05-23'),
(6,'Sneha',26,'Finance',48000,'Mumbai','2022-08-19'),
(7,'Rohan',32,'IT',65000,'Pune','2021-09-10'),
(8,'Anita',29,'HR',35000,'Delhi','2020-02-14'),
(9,'Arjun',31,'Finance',52000,'Pune','2021-06-11'),
(10,'Reema',27,'IT',58000,'Mumbai','2023-01-05');

select * from employees1;

-- 1. Retrieve records where the combination of department and city is unique (no duplicate combinations).

select DISTINCT Department, City from employees1;

-- 2. Find employees whose names start with either 'A' or 'R'.

select * from employees1
where name like 'A%' OR name like 'R%';

-- 3. Find employees whose second character in the name is 'a'.

select * from employees1
where name like '_a%';

-- 4. Retrieve employees whose names are exactly 5 characters long.

select * from employees1
where name like '_____';

-- 5. Find employees whose names end with a vowel (a, e, i, o, u).

select * from employees1
where name like '%a' OR name like '%e' or name like '%i' or name like '%o' or name like '%u';

-- 6. Increase the salary by 10% for IT employees whose salary is less than 65000.

select *, (salary + (salary * 10/100)) AS updated_Salary_IT from employees1
where department = 'IT' AND Salary < 65000;

-- 7. Update the city to 'Pune' for employees who belong to HR department and earn less than 40000.

SET SQL_SAFE_UPDATES = OFF;

UPDATE employees1
SET City = 'Pune'
where department = 'HR' AND Salary < 40000;

select * from employees1;

-- 8. Increase salary by 5% for employees whose age is greater than 30.

UPDATE employees1
SET Salary = (Salary + (Salary*5/100))
WHERE age >30;

select * from employees1;

-- 9. Update department name from 'Finance' to 'FinTech' only for employees whose salary is greater than 50000.

UPDATE employees1
SET department = 'FinTech'
WHERE department = 'Finance' AND salary > 50000;

select * from employees1;

-- 10. Delete employees whose salary is below the average salary of all employees.

DELETE FROM EMPLOYEES1 
WHERE Salary < (select average_salary from
(select avg(salary) AS average_salary from employees1) AS temp);


DELETE FROM EMPLOYEES1
WHERE Salary < (select average_salary from
(select avg(Salary) AS average_salary from employees1) AS temp);


-- use assignments;
-- drop table employees1;

select * from employees1;

-- DROP TABLE Employees1;

select * from employees1;

-- 11. Delete employees from departments that have only one employee.

UPDATE employees1
SET department = 'FinTech'
WHERE department = 'Finance' AND salary > 50000;

select * from employees1;

DELETE FROM EMPLOYEES1
WHERE Department IN (select Department from 
(select Department from employees1 
group by department having count(emp_id) < 2) AS temp);

select * from employees1;

-- 12. Write a TRUNCATE query and briefly explain its effect on the table.

-- Syntax :

-- TRUNCATE TABLE Table_Name;

-- The truncate command is a DDL command that is used to remove / delete all the records of the table without impacting the structure of the table.

-- 13. Add a new column 'bonus' of type INT with default value 1000.

ALTER TABLE EMPLOYEES1
ADD COLUMN Bonus INT DEFAULT 1000;

select * from employees1;

-- 14. Modify the salary column datatype to DECIMAL(10,2).

ALTER TABLE EMPLOYEES1
MODIFY COLUMN Salary DECIMAL(10,2);

DESC EMPLOYEES1;

-- 15. Rename the column 'city' to 'location'.

ALTER TABLE EMPLOYEES1
RENAME COLUMN City TO Location;

select * from employees1;

-- 16. Calculate the total salary for each department.

select department, SUM(Salary) AS Total_Salary_PD from employees1 
group by department;

-- 17. Find the average salary of employees whose age is greater than 30.

select AVG(Salary) AS Average_Salary from employees1
where age > 30;

select * from employees1;

-- 18. Find the maximum and minimum salary in each city.

select City, MAX(Salary) AS Max_Salary, MIN(Salary) AS Min_Salary FROM EMPLOYEES1
GROUP BY City;

-- 19. Count the number of employees in each city.


select City, Count(name) AS T_E_P_C FROM EMPLOYEES1
GROUP BY City;

-- 20. Calculate department-wise average salary.

select department, avg(salary) AS D_A_S FROM employees1
group by department;

-- 21. Find the number of employees in each city and sort the result by highest count.

select City, COUNT(Name) AS Employee_Count_PC FROM EMPLOYEES1
GROUP BY City
ORDER BY Employee_Count_PC DESC;

-- 22. Calculate total salary for each combination of city and department.

SELECT City, Department, SUM(Monthly_Salary) AS Monthly_Salary FROM EMPLOYEES1
GROUP BY Department,City;

-- 23. Find departments where the average salary is greater than 50000.

SELECT Department, AVG(Salary) AS Average_Salary FROM EMPLOYEES1
GROUP BY Department
HAVING Average_Salary > 50000;

-- 24. Find cities where more than 2 employees are working.

SELECT City, COUNT(Name) As Total_Employees FROM EMPLOYEES1
GROUP BY City
HAVING Total_Employees > 2;

-- 25. Sort employees by department in ascending order and salary in descending order.

SELECT Emp_Name, Department, Monthly_Salary FROM EMPLOYEES1
ORDER BY Department ASC, Monthly_Salary DESC;

-- 26. Sort employees by join_date from latest to oldest.

SELECT Name, Join_Date FROM EMPLOYEES1
ORDER BY Join_date DESC;

-- 27. Display top 2 highest paid employees.

SELECT * FROM EMPLOYEES1
ORDER BY Salary DESC
LIMIT 2;

-- 28. Fetch employees with 3rd and 4th highest salaries.

SELECT * FROM EMPLOYEES1
ORDER BY Salary DESC
LIMIT 2 OFFSET 2;

-- 29. Display name as Emp_Name and salary as Monthly_Salary.

ALTER TABLE EMPLOYEES1
RENAME COLUMN Name TO Emp_Name;

ALTER TABLE EMPLOYEES1
RENAME COLUMN Salary TO Monthly_Salary;

select * from employees1;

-- 30. Display annual salary (salary * 12) as Annual_Salary.

SELECT *, Monthly_Salary *12 AS Annual_Salary FROM EMPLOYEES1;

-- 31. Find employees whose salary is greater than the average salary of their department and display results sorted by salary in descending order.

-- select * from employees1;

SELECT Emp_Name, Department, Monthly_Salary 
FROM EMPLOYEES1 AS e
WHERE Monthly_Salary > (SELECT AVG(Monthly_Salary) FROM EMPLOYEES1
WHERE Department = e.Department)
ORDER BY Monthly_Salary DESC;

-- 32. Retrieve top 3 highest paid employees from each department using ORDER BY and LIMIT.

SELECT *,
ROW_NUMBER() OVER(PARTITION BY Department ORDER BY Monthly_Salary DESC) AS H_L_Salary 
FROM EMPLOYEES1;

-- 33. Find departments where the total salary is greater than 100000 and display them in descending order of total salary.

SELECT Department, SUM(Monthly_Salary) AS Total_Salary FROM EMPLOYEES1
GROUP BY Department
HAVING Total_Salary > 100000
ORDER BY Total_Salary DESC;

-- 34. Update salary by 10% for employees whose salary is below the average salary of their city.

SELECT Emp_Name, City, Monthly_Salary FROM EMPLOYEES1 AS e
WHERE Monthly_Salary < (SELECT AVG(Monthly_Salary) FROM EMPLOYEES1
WHERE City = e.City);

UPDATE EMPLOYEES1
SET Monthly_Salary = Monthly_Salary + (Monthly_Salary * 10/100)
WHERE Emp_Name IN ('Amit','Sneha','Anita','Arjun');

select * from employees1;

-- 35. Delete employees whose salary is less than the minimum salary of their department.

SELECT Emp_Name, Department, City, Monthly_Salary FROM EMPLOYEES1 AS e
WHERE Monthly_Salary = (SELECT MIN(Monthly_Salary) FROM EMPLOYEES1
WHERE Department = e.Department);

DELETE FROM employees1
WHERE Emp_Name IN ('Amit','Raj','Reema');

select * from employees1;

-- 36. Display department-wise employee count along with average salary, but only include departments having more than 2 employees.

SELECT Department, COUNT(Emp_Name), AVG(Monthly_Salary) FROM EMPLOYEES1 
GROUP BY Department
HAVING COUNT(Emp_Name) > 2;

-- 37. Find employees whose name starts with 'A' and salary is among the top 5 highest salaries.

SELECT Emp_Name, Department, City, Monthly_Salary FROM EMPLOYEES1
WHERE Emp_Name LIKE 'A%'
ORDER BY Monthly_Salary DESC;

-- 38. Find employees whose salary is greater than the average salary of their respective department.

SELECT Emp_Name, Department, City, Monthly_Salary FROM EMPLOYEES1 AS e
WHERE Monthly_Salary > (SELECT AVG(Monthly_Salary) FROM EMPLOYEES1
WHERE Department = e.Department);

-- 39. Find the second highest salary without using LIMIT.

select * from employees1
where monthly_salary = ( select MAX(Monthly_Salary) from employees1
where monthly_salary < (select MAX(Monthly_Salary) from employees1));












