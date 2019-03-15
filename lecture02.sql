USE employees;

#find how many employees there are
SELECT COUNT(DISTINCT emp_no) FROM salaries;

#find how many times an employee has gotten a raise
SELECT emp_no, MAX(salary), COUNT(*) numOfRaises FROM salaries 
	GROUP BY emp_no;
    
SELECT emp_no, to_date, from_date, DATEDIFF(to_date, from_date) dateDiff FROM salaries;

SELECT DISTINCT to_date FROM salaries 
	ORDER BY to_date desc;
	
SELECT * FROM salaries
	WHERE to_date > '1990-01-01';
    
#How many number of managers per department
SELECT dept_no, COUNT(DISTINCT emp_no) numOfManagers FROM dept_manager
	GROUP BY dept_no;
    
#how many employees working for each dept
SELECT dept_no, COUNT(DISTINCT emp_no) numOfEmployees FROM dept_emp
	GROUP bY dept_no;
    
#what is min, max, and avg salary for each position
SELECT title, MIN(salary) minSalary, MAX(salary) maxSalary, AVG(salary) avgSalary, count(DISTINCT t.emp_no) numOfEmployees 
	FROM salaries s, titles t
	WHERE s.emp_no = t.emp_no
	GROUP BY title
    ORDER BY avgSalary DESC;
    
#list # of employees working as managers for company > than 3 years
select e.emp_no, first_name, last_name,  gender, ROUND(DATEDIFF(to_date, from_date) / 365, 0) AS numOfYears, hire_date FROM employees e, titles t
	WHERE DATEDIFF(to_date, from_date) / 365 > 3 AND title = 'manager' AND e.emp_no = t.emp_no and gender = 'M'
    ORDER BY DATEDIFF(to_date, from_date) DESC;
    
SELECT title, dept_name, MAX(salary), first_name, last_name FROM employees e, departments d, salaries s, dept_emp de, titles t
	WHERE s.emp_no = e.emp_no AND d.dept_no = de.dept_no AND de.emp_no = e.emp_no AND t.emp_no = e.emp_no
    GROUP BY title, dept_name, first_name, last_name;
    
#filter employees table with only those who hold engineer possible
SELECT e.emp_no, first_name, last_name, gender, title
	FROM titles t LEFT JOIN employees e ON e.emp_no = t.emp_no
	WHERE title = 'engineer';
    
SELECT * FROM employees
	WHERE first_name LIKE '%son';