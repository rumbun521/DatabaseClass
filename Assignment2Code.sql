#Select database to use
USE employees;

#Question 2
#Find the average, minimum, and maximum salarires of male and female employees
SELECT gender, AVG(salary) AS averageSalary, MIN(salary) AS minSalary, MAX(salary) AS maxSalary FROM salaries s, employees e
	WHERE s.emp_no = e.emp_no
    GROUP BY gender;
#Find how many male and female employees there are in the database
SELECT gender, COUNT(gender) AS numOfEmployees FROM employees
	GROUP BY gender;

#Question 3
#Counts how many employees that were working for the dept number 'd007' between 1985-01-01 and 1991-03-07
SELECT COUNT(emp_no) AS numOfEmployees FROM dept_emp 
	WHERE dept_no = 'd007' AND to_date > '1991-03-07' AND from_date < '1986-01-01';

#Question 4
#Find how many distinct employee numbers there are in the database
SELECT COUNT(DISTINCT emp_no) AS numOfDistinctEmployees FROM employees;
#Group the employee numbers and get the average salary for each group
SELECT emp_no, AVG(salary) AS averageSalary FROM salaries
	GROUP BY emp_no
    ORDER BY emp_no;

#Question 5
#Get how many employees are listed as senior staff or staff
SELECT COUNT(emp_no) AS employeeCount FROM titles
	WHERE title = 'senior staff' OR title = 'staff';