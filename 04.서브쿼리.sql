-- 서브쿼리
-- 1. 단일 행 서브쿼리
SELECT *
  FROM employees
 WHERE phone_number = (SELECT phone_number
                        FROM employees
                       WHERE employee_id = 100);
---------------------------------------------------------------------------------                       
SELECT *
  FROM employees
 WHERE hire_date = ( SELECT hire_date
                       FROM employees
                      WHERE email = 'SKING');
---------------------------------------------------------------------------------                      
SELECT *
  FROM employees
 WHERE hire_date < ( SELECT hire_date
                       FROM employees
                      WHERE email = 'SKING');
---------------------------------------------------------------------------------
SELECT *
  FROM employees
 WHERE salary = ( SELECT salary
                    FROM employees
                   WHERE hire_date = '2006-01-03');

-- 2. 다중 행 서브쿼리
SELECT *
  FROM employees
 WHERE salary IN ( SELECT MAX(salary)
                     FROM employees
                 GROUP BY department_id)
ORDER BY department_id;
---------------------------------------------------------------------------------
SELECT *
  FROM employees
 WHERE salary NOT IN ( SELECT MAX(salary)
                     FROM employees
                 GROUP BY department_id)
ORDER BY department_id;
---------------------------------------------------------------------------------
SELECT *
  FROM employees
 WHERE EXISTS (SELECT *
                 FROM employees
                WHERE employee_id = 100);
---------------------------------------------------------------------------------
SELECT *
  FROM employees
 WHERE salary < ANY ( SELECT salary
                        FROM employees
                       WHERE hire_date > '08/01/01'
                    )
ORDER BY hire_date;
---------------------------------------------------------------------------------
SELECT *
  FROM employees
 WHERE salary < ALL ( SELECT salary
                        FROM employees
                       WHERE hire_date > '08/01/01')
ORDER BY hire_date;
---------------------------------------------------------------------------------
SELECT *
  FROM employees
 WHERE salary > ANY ( SELECT MAX(salary)
                        FROM employees
                    GROUP BY department_id)
ORDER BY salary;
---------------------------------------------------------------------------------
SELECT *
  FROM employees
 WHERE salary < ALL ( SELECT MAX(salary)
                        FROM employees
                    GROUP BY department_id)
ORDER BY salary;
---------------------------------------------------------------------------------
SELECT *
  FROM employees
 WHERE salary < ANY ( SELECT MAX(salary)
                        FROM employees
                    GROUP BY department_id)
ORDER BY salary;
---------------------------------------------------------------------------------
SELECT *
  FROM employees
 WHERE salary > ALL ( SELECT MAX(salary)
                        FROM employees
                    GROUP BY department_id)
ORDER BY salary;
---------------------------------------------------------------------------------
SELECT *
  FROM employees e, ( SELECT department_id
                        FROM departments
                       WHERE department_name = 'IT') d
 WHERE e.department_id = d.department_id;                       
---------------------------------------------------------------------------------
SELECT e.emp_name, e.salary, d.avgsal
  FROM employees e, ( SELECT department_id, AVG(salary) avgsal
                        FROM employees
                    GROUP BY department_id) d
 WHERE e.department_id = d.department_id
   AND e.salary > d.avgsal;
---------------------------------------------------------------------------------
SELECT department_name , ( SELECT AVG(salary) 
                             FROM employees
                         GROUP BY department_name) avgsal
  FROM departments;                        
---------------------------------------------------------------------------------
SELECT ROWNUM, salary
  FROM ( SELECT salary
           FROM employees
       ORDER BY salary desc)
 WHERE ROWNUM <= 10;
---------------------------------------------------------------------------------
-- 연습문제 1
-- departments테이블에서 department_name이 'IT'인 department_id와 일치하는
-- employees테이블의 employee_id, emp_name, job_id, salary 조회
SELECT employee_id, emp_name, job_id, salary
  FROM employees
 WHERE department_id = ( SELECT department_id
                           FROM departments
                          WHERE department_name = 'IT');
---------------------------------------------------------------------------------
-- 연습문제 2
-- location테이블에서 state_province가 'California'인 location_id와 일치하는
-- departments테이블이 department_id, department_name을 조회
SELECT department_id, department_name
  FROM departments
 WHERE location_id = ( SELECT location_id
                         FROM locations
                        WHERE state_province = 'California');
---------------------------------------------------------------------------------
-- 연습문제 3
-- COUNTRIES테이블에서 region_id가 3인 country_id가 포함된
-- location테이블의 city, state_province, street_address를 조회
SELECT city, state_province, street_address
  FROM locations
 WHERE country_id IN ( SELECT country_id
                        FROM countries
                      WHERE region_id = 3);
---------------------------------------------------------------------------------
-- 연습문제 4
-- departments테이블에서 manager_id가 null이 아닌 department_id와 일치하는
-- employees테이블의 emp_name, job_id, salary 조회
SELECT emp_name, job_id, salary
  FROM employees
 WHERE department_id IN ( SELECT department_id
                           FROM departments
                          WHERE department_id IS NOT NULL);
---------------------------------------------------------------------------------
-- 연습문제 5
-- location테이블에서 city가 'Seattle'을 포함하지 않는 location_id와 일치하는
-- departments테이블의 department_id, department_name 조회
SELECT departmetn_id, department_name
  FROM departments
 WHERE location_id NOT IN ( SELECT location_id
                         FROM locations
                        WHERE city = 'Seattle');
---------------------------------------------------------------------------------
-- 연습문제 6
-- region테이블에서 region_name이 'Europe'인 region_id가 일치하는 countries테이블에서
-- country_id가 포함된 locations테이블의 city, state_province, street_address 조회
SELECT city, state_province, street_address
  FROM locations
 WHERE country_id IN (SELECT country_id
                       FROM countries
                      WHERE region_id = (SELECT region_id
                                           FROM region
                                          WHERE region_name = 'Europe'));