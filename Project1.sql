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
    
# (2.2) sort employees based on hire date and department
SELECT e.emp_no, first_name, last_name, gender, hire_date, dept_no FROM employees e, dept_emp d
	WHERE e.emp_no = d.emp_no
	ORDER BY hire_date, dept_no;

# (2.3) Find how many years employees have worked for company who are female
SELECT emp_no, first_name, last_name, hire_date, DATEDIFF(CURDATE(), hire_date)/365 AS years_worked
	FROM employees
	WHERE gender = 'F';
    
# (2.4) Find all employees that were hired more than 10 years ago
SELECT *
	FROM (
		SELECT emp_no, first_name, last_name, hire_date, DATEDIFF(CURDATE(), hire_date)/365 AS years_worked
			FROM employees
            ) as INNERTABLE
				WHERE years_worked > 10;
                
# (3.1) Display titles and departments in one column
SELECT title as title_and_dept FROM titles
	UNION 
		SELECT dept_name FROM departments;

# (3.2) Show employees with department name
SELECT e.emp_no, first_name, last_name, dept_name
	FROM employees e, dept_emp de, departments d
		WHERE e.emp_no = de.emp_no AND de.dept_no = d.dept_no;
        
# (3.3) Show employees that are not a department manager
SELECT emp_no, first_name, last_name
	FROM employees
    WHERE emp_no NOT IN (SELECT emp_no FROM dept_manager);

# (3.4) Get the sum, average, and maximum salaries of all employees as well as count how many distinct employees there are
SELECT count(DISTINCT emp_no) AS total_emp, sum(salary) AS salary_sum, avg(salary) AS average_salary, max(salary) AS max_salary
	FROM salaries;

# (4.1) Insert a new departmnet into departments table
INSERT INTO departments (dept_no, dept_name)
	VALUES ('DP6', 'Customer Relations');
    
# (4.2) Add a manager for the new department in the employees database
INSERT  INTO dept_manager (emp_no, dept_no, from_date)
	SELECT emp_no, dept_no, hire_date
		FROM employees e, departments d
        WHERE dept_no = 'DP6' AND e.emp_no = 1;

# (4.3) Give all employees a 10% raise
UPDATE salaries
	SET salary = salary * 1.10;

# (4.4) Delete the new department
DELETE FROM departments WHERE dept_no = 'DP6';

# gets employee names that make more than the average salary
SELECT DISTINCT first_name, last_name FROM employees e, salaries s
	WHERE e.emp_no = s.emp_no AND salary > (SELECT AVG(salary) FROM salaries);
    
