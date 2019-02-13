#SELECT COUNT(DISTINCT emp_No) AS 'EmployeeCount' FROM salaries WHERE salary <= 50000 OR salary >= 60000;
#SELECT COUNT(emp_No) AS 'EngineerCount' FROM titles WHERE title NOT IN ('engineer', 'senior engineer');
SELECT SUM(salary) From salaries ORDER BY salary, from_date DESC;