-- ��������
-- 1. ���� �� ��������
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

-- 2. ���� �� ��������
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
-- �������� 1
-- departments���̺��� department_name�� 'IT'�� department_id�� ��ġ�ϴ�
-- employees���̺��� employee_id, emp_name, job_id, salary ��ȸ
SELECT employee_id, emp_name, job_id, salary
  FROM employees
 WHERE department_id = ( SELECT department_id
                           FROM departments
                          WHERE department_name = 'IT');
---------------------------------------------------------------------------------
-- �������� 2
-- location���̺��� state_province�� 'California'�� location_id�� ��ġ�ϴ�
-- departments���̺��� department_id, department_name�� ��ȸ
SELECT department_id, department_name
  FROM departments
 WHERE location_id = ( SELECT location_id
                         FROM locations
                        WHERE state_province = 'California');
---------------------------------------------------------------------------------
-- �������� 3
-- COUNTRIES���̺��� region_id�� 3�� country_id�� ���Ե�
-- location���̺��� city, state_province, street_address�� ��ȸ
SELECT city, state_province, street_address
  FROM locations
 WHERE country_id IN ( SELECT country_id
                        FROM countries
                      WHERE region_id = 3);
---------------------------------------------------------------------------------
-- �������� 4
-- departments���̺��� manager_id�� null�� �ƴ� department_id�� ��ġ�ϴ�
-- employees���̺��� emp_name, job_id, salary ��ȸ
SELECT emp_name, job_id, salary
  FROM employees
 WHERE department_id IN ( SELECT department_id
                           FROM departments
                          WHERE department_id IS NOT NULL);
---------------------------------------------------------------------------------
-- �������� 5
-- location���̺��� city�� 'Seattle'�� �������� �ʴ� location_id�� ��ġ�ϴ�
-- departments���̺��� department_id, department_name ��ȸ
SELECT departmetn_id, department_name
  FROM departments
 WHERE location_id NOT IN ( SELECT location_id
                         FROM locations
                        WHERE city = 'Seattle');
---------------------------------------------------------------------------------
-- �������� 6
-- region���̺��� region_name�� 'Europe'�� region_id�� ��ġ�ϴ� countries���̺���
-- country_id�� ���Ե� locations���̺��� city, state_province, street_address ��ȸ
SELECT city, state_province, street_address
  FROM locations
 WHERE country_id IN (SELECT country_id
                       FROM countries
                      WHERE region_id = (SELECT region_id
                                           FROM region
                                          WHERE region_name = 'Europe'));