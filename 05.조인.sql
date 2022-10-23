-- ����
-- 1. �̳�����
-- 1-1. �������� - �⺻Ű�� �ܷ�Ű�� �Ű��� ����
-- (1) ��ü ������ �����ȣ, �����, �μ���ȣ, �μ����� ��ȸ
SELECT employee_id, emp_name, d.department_id, department_name
  FROM employees e, departments d
 WHERE e.department_id = d.department_id;
----------------------------------------------------------------------------------------
-- (2) ���� ���ÿ� ���ϴ� ���� ��������� ����, ���ø�, �����ȣ, ����� ��ȸ
SELECT c.cust_name, c.city, s.salesman_id, s.name
  FROM customer_ex c, salesman s
 WHERE c.city = s.city;
----------------------------------------------------------------------------------------
-- (3) �ֹ��ݾ��� 500~2000������ �ֹ��� ���ؼ� �ֹ���ȣ, �ֹ��ݾ�, ����ȣ, �ֹ����� ��ȸ
SELECT o.ord_no, o.purch_amt, c.customer_id, c.city
  FROM orders_ex o, customer_ex c
 WHERE o.purch_amt BETWEEN 500 AND 2000
   AND o.customer_id = c.customer_id;
----------------------------------------------------------------------------------------
-- 1-2. �������� - IN�� EXISTS�� ���
-- (1) EXISTS�� ����� �޿��� 3000�̻��� ����� �μ���ȣ, �μ��� ��ȸ
SELECT d.department_id, department_name
  FROM departments d
 WHERE EXISTS (SELECT *
                 FROM employees e
                WHERE salary >= 3000
                  AND e.department_id = d.department_id);
----------------------------------------------------------------------------------------
-- (2) IN�� ����� �޿��� 3000�̻��� ����� �μ���ȣ, �μ��� ��ȸ
SELECT d.department_id, department_name
  FROM departments d
 WHERE d.department_id IN ( SELECT department_id
                           FROM employees
                          WHERE salary >= 3000);
----------------------------------------------------------------------------------------
-- 1-3. �������� - ������ ���̺��� ����� ����(�� ���̺��� �÷����� ����)
----------------------------------------------------------------------------------------
-- 2. OUTER JOIN
-- (2-1)cust_ex, buy���̺��� �̿��� ����ȣ, ����, ��ǰ��ȣ, �ݾ� ��ȸ
SELECT c.custid, c.name, b.num, b.price
  FROM cust_ex c, buy b
 WHERE c.custid = b.custid(+);
----------------------------------------------------------------------------------------
-- (2-2) employees���̺��� ��� ����� ���� �����ȣ, �����, ��å��ȣ, ������, ������ ��ȸ
SELECT e.employee_id, e.emp_name, e.job_id, j.start_date, j.end_date
  FROM employees e, job_history j
 WHERE e.employee_id = j.employee_id(+);
----------------------------------------------------------------------------------------
-- (2-3)
SELECT *
  FROM jobs j, job_history jj
 WHERE j.job_id = jj.job_id(+);
----------------------------------------------------------------------------------------
-- 3. �Ƚ�����
-- (3-1) -- 2003�� 1�� 1�� ���Ŀ� �Ի��� ����� ���, �̸�, �μ���ȣ, �μ��� ��ȸ
-- (1) ���� ����Ŭ ���� ���
SELECT employee_id, emp_name, e.department_id, department_name
  FROM employees e, departments d
 WHERE hire_date > '2003-01-01'
   AND e.department_id = d.department_id;

-- (2) ANSI JOIN���� ���
SELECT employee_id, emp_name, e.department_id, department_name
  FROM employees e
 INNER JOIN departments d
    ON e.department_id = d.department_id
 WHERE hire_date > '2003-01-01';
----------------------------------------------------------------------------------------
-- (3-2) ��� ������ �߷ɳ��� ��ȸ
SELECT e.employee_id, e.emp_name, j.job_id, j.start_date, j.end_date
  FROM employees e
LEFT OUTER JOIN job_history j
    ON e.employee_id = j.employee_id;
----------------------------------------------------------------------------------------
-- (3-3) ��� ��������� �������� ��ȸ�Ͽ� ���������� ��ȸ
SELECT s.name, s.salesman_id, c.customer_id, c.cust_name, c.city, c.grade
  FROM salesman s
LEFT OUTER JOIN customer_ex c
    ON s.salesman_id = c.salesman_id
ORDER BY s.name;