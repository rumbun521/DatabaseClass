#SELECT COUNT(DISTINCT emp_No) AS 'EmployeeCount' FROM salaries WHERE salary <= 50000 OR salary >= 60000;
#SELECT COUNT(emp_No) AS 'EngineerCount' FROM titles WHERE title NOT IN ('engineer', 'senior engineer');
#SELECT SUM(salary) From salaries ORDER BY salary, from_date DESC;
#SELECT MIN(salary) AS Minimum, MAX(salary) AS Maximum, AVG(salary) AS Average FROM salaries;
#SELECT salary, COUNT(salary) FROM salaries GROUP BY salary;
SELECT emp_no, salary - (SELECT AVG(salary) FROM salaries) AS AvgSalaryDiff FROM salaries WHERE salary > (SELECT AVG(salary) FROM salaries);