#Use the employees database
USE employees;

#(1.1) retrieves all information about every employee
SELECT * FROM employees;

#(1.2) gets the hire dates for each employee
SELECT emp_no, first_name, last_name, hire_date FROM employees;

#(1.3) retrieves emp_no that are not managers
SELECT emp_no FROM titles
	WHERE title != 'manager';

#(1.4) retrieves emp_no that are not engineers or managers
SELECT emp_no FROM titles
	WHERE title != 'manager' AND title != 'engineer';
    
#(1.5) retrieves employee name and birth date with customized column names
SELECT first_name AS FirstName, last_name AS LastName, birth_date as BirthDate
	FROM employees;
    
# (1.6) concatinates the first name and last name of employees that are female
SELECT concat(last_name, ', ', first_name) AS name
	FROM employees
	WHERE gender = 'f';
    
# (1.7) shows if the employee has a birthday
SELECT concat(last_name, ', ', first_name) AS name, 
	CASE WHEN MONTH(birth_date) = MONTH(NOW()) AND DAY(birth_date) = DAY(NOW()) then 'Happy Birthday!'
		ELSE ' '
    END AS birthdayStatus
    FROM employees;
    
# (1.8)	show the 5 most recently hired employees with hire dates
SELECT emp_no, first_name, last_name, hire_date FROM employees
	ORDER BY hire_date DESC
    LIMIT 5;
	
# (1.9) list all employees with manager or engineer title
SELECT emp_no, title
		FROM titles
		WHERE title IN ('manager', 'engineer');

# (1.10) list all employees with a -ian at the end of last name
SELECT emp_no, first_name, last_name 
	FROM employees	
    WHERE last_name LIKE '%ian';

# (2.1) Show the top 5 highest salaries with names
SELECT e.emp_no, first_name, last_name, salary
	FROM salaries s, employees e
	WHERE e.emp_no = s.emp_no
    ORDER BY salary DESC
    LIMIT 5;
    
# (2.2) 

# gets employee names that make more than the average salary
SELECT DISTINCT first_name, last_name FROM employees e, salaries s
	WHERE e.emp_no = s.emp_no AND salary > (SELECT AVG(salary) FROM salaries);
    
