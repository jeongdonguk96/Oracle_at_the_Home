-- ���� ��������
-- (1) countries���̺�� locatio���̺��� country_id�� �������� �����Ͽ�
-- country_name, state_province, street_address�� ��ȸ
SELECT country_name, state_province, street_address
  FROM countries c, location l
 WHERE c.country_id = l.country_id;
----------------------------------------------------------------------------------------
-- (2) jobs���̺�� job_history���̺��� job_id�� �������� �����Ͽ�
-- job_id, job_title, start_date, end_date�� ��ȸ
SELECT j.job_id, j.job_title, jj.start_date, jj.end_date
  FROM jobs j, job_history jj
 WHERE j.job_id = jj.job_id;
----------------------------------------------------------------------------------------
-- (3) employees���̺�� departments���̺��� department_id�� �������� �����ϰ�
-- employees���̺�� jobs���̺��� job_id�� �������� �����Ͽ�
-- emp_name, department_name, job_title ��ȸ
SELECT emp_name, department_name, job_title
  FROM employees e, departments d, jobs j
 WHERE e.department_id = d.department_id
   AND e.job_id = j.job_id;
----------------------------------------------------------------------------------------
-- (4) countries���̺�� locatio���̺��� location���̺��� country_id�� �������� �����Ͽ�
-- country_id, country_name, city�� ��ȸ
SELECT country_id, country_name, city
  FROM countries c, location l
 WHERE l.country_id = c.country_id(+);
----------------------------------------------------------------------------------------
-- (5) employees���̺�� departments���̺���  departments���̺��� department_id�� �������� �����ϰ�
-- employees���̺�� jobs���̺��� job_id�� �������� �����Ͽ�
-- employee_id, emp_name, department_name�� ��ȸ
SELECT e.employee_id, e.emp_name, d.department_name
  FROM employees e, departments d
 WHERE d.department_id(+) = e.department_id;
----------------------------------------------------------------------------------------
-- (6) employees���̺��� manager_id�� employee_id�� �������� ���������� ��
-- ������ emp_name�� �������� emp_name�� employee_id�� �������� ���� �� ��ȸ
SELECT a.emp_name, b.employee_id
  FROM employees a, employees b
 WHERE a.employee_id = b.manager_id
ORDER BY employee_id;