-- 조인 연습문제
-- (1) countries테이블과 locatio테이블을 country_id를 기준으로 조인하여
-- country_name, state_province, street_address를 조회
SELECT country_name, state_province, street_address
  FROM countries c, location l
 WHERE c.country_id = l.country_id;
----------------------------------------------------------------------------------------
-- (2) jobs테이블과 job_history테이블을 job_id를 기준으로 조인하여
-- job_id, job_title, start_date, end_date를 조회
SELECT j.job_id, j.job_title, jj.start_date, jj.end_date
  FROM jobs j, job_history jj
 WHERE j.job_id = jj.job_id;
----------------------------------------------------------------------------------------
-- (3) employees테이블과 departments테이블을 department_id를 기준으로 조인하고
-- employees테이블과 jobs테이블을 job_id를 기준으로 조인하여
-- emp_name, department_name, job_title 조회
SELECT emp_name, department_name, job_title
  FROM employees e, departments d, jobs j
 WHERE e.department_id = d.department_id
   AND e.job_id = j.job_id;
----------------------------------------------------------------------------------------
-- (4) countries테이블과 locatio테이블을 location테이블의 country_id를 기준으로 조인하여
-- country_id, country_name, city를 조회
SELECT country_id, country_name, city
  FROM countries c, location l
 WHERE l.country_id = c.country_id(+);
----------------------------------------------------------------------------------------
-- (5) employees테이블과 departments테이블을  departments테이블의 department_id를 기준으로 조인하고
-- employees테이블과 jobs테이블을 job_id를 기준으로 조인하여
-- employee_id, emp_name, department_name을 조회
SELECT e.employee_id, e.emp_name, d.department_name
  FROM employees e, departments d
 WHERE d.department_id(+) = e.department_id;
----------------------------------------------------------------------------------------
-- (6) employees테이블을 manager_id와 employee_id를 기준으로 셀프조인한 후
-- 직원의 emp_name과 관리자의 emp_name을 employee_id를 기준으로 정렬 후 조회
SELECT a.emp_name, b.employee_id
  FROM employees a, employees b
 WHERE a.employee_id = b.manager_id
ORDER BY employee_id;