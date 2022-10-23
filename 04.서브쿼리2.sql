-- ��������2
-- 1. 1���� �÷� ���� ��ȯ�ϴ� ����������
-- (1-1) orders_ex���̺��� �ֹ����ڰ� 2012-10-10�� ��� �ֹ��ݾ׺��� ū �ֹ��ݾ� ��ȸ
SELECT *
  FROM orders_ex
 WHERE purch_amt > (SELECT AVG(purch_amt)
                      FROM orders_ex
                     WHERE ord_date = '2012-10-10');
---------------------------------------------------------------------------------
-- (1-2) departments���̺��� parent_id�� ���� �μ��� ���ϴ� ������� ��ȸ
SELECT count(*)
  FROM employees
 WHERE department_id = ( SELECT department_id
                           FROM departments
                          WHERE parent_id = NULL);
---------------------------------------------------------------------------------
-- (1-3) �Ŵ����� �����ϴ� �μ��� ���ϴ� ����� �� ��ȸ
SELECT count(*)
  FROM employees
 WHERE department_id IN ( SELECT department_id
                            FROM departments
                           WHERE manager_id IS NOT NULL);
---------------------------------------------------------------------------------
-- (1-4) salesman, order_ex���̺��� �̿��� paris�� ����ϴ� ��������鿡 ���� ��� �ֹ������� ��ȸ
SELECT *
  FROM orders_ex
 WHERE salesman_id = ANY ( SELECT salesman_id
                         FROM salesman
                        WHERE city = 'Paris');
---------------------------------------------------------------------------------
-- (1-5) salesman, orders_ex���̺��� �̿��� paul adam�� �Ǹ��� ��� �ֹ������� ��ȸ
SELECT *
  FROM orders_ex
 WHERE salesman_id = ANY (SELECT salesman_id
                            FROM salesman
                           WHERE name = 'Paul Adam');
---------------------------------------------------------------------------------
-- 2. ���ÿ� 2�� �̻��� �÷� ���� ��ȯ�ϴ� ��������
-- (2-1) employees���̺��� job_history���̺� �����ϴ� �����ȣ, ��å��ȣ ���� ������ ����� ������ ��ȸ
SELECT *
  FROM employees
 WHERE (employee_id, job_id) = ANY ( SELECT employee_id, job_id
                                     FROM job_history);
---------------------------------------------------------------------------------
-- (2-2) �μ����� �ִ�޿��� �޴� ����� �����ȣ, �����, �޿� ��ȸ (�μ���ȣ, �μ��� �ִ�޿� ��ȸ)
SELECT *
  FROM employees
 WHERE (NVL(department_id, 0), salary) = ANY ( SELECT NVL(department_id, 0), MAX(salary)
                                                 FROM employees
                                             GROUP BY department_id);
---------------------------------------------------------------------------------
-- 3 SELECT�� �ƴ� �ٸ� �������� ���
-- (3-1) ��� ����� �޿��� �� ����� ��ձ޿��� ����
UPDATE salary
   SET salary = ( SELECT AVG(salary) FROM employees);
---------------------------------------------------------------------------------
-- 4. ������ �ִ� ��������
-- (4-1) job_history�� �����ϴ� ��� ���ڵ忡 ���� �μ���ȣ�� ������
-- department���̺��� �μ���ȣ, �μ��� ��ȸ
SELECT department_id, department_name
  FROM departments d
 WHERE EXISTS (SELECT department_id
                 FROM job_history j
                WHERE j.department_id = d.department_id);
---------------------------------------------------------------------------------
-- (4-2) salesman, customer_ex���̺��� ������ 2�� �̻��� ���� ���� ��������� ���� ��ȸ
SELECT *
  FROM salesman s
 WHERE salesman_id, count(salesman_id) = ( SELECT salesman_id, count(salesman_id)
                                             FROM customer_ex c
                                         GROUP BY salesman_id);
---------------------------------------------------------------------------------
-- 5. SELECT������ ��������
-- (5-1) job_history�� ��� �࿡ ���� �����ȣ, �����, �μ���ȣ, �μ��� ��ȸ
SELECT j.employee_id,
       ( SELECT emp_name
           FROM employees e
          WHERE e.employee_id = j.employee_id),
       j.department_id,
       ( SELECT department_name
           FROM departments d
          WHERE d.department_id = j.department_id)                   
  FROM job_history j;                   
---------------------------------------------------------------------------------
-- (5-2) orders_ex���̺��� ��ü �ֹ��� ��ȸ�ϰ� �� �ֹ��� ����� ����������� �Բ� ��ȸ
SELECT ord_no, purch_amt, ord_date, ( SELECT cust_name
                                        FROM customer_ex c
                                       WHERE c.customer_id = o.customer_id) ����,
                                    ( SELECT name
                                        FROM salesman s
                                       WHERE s.salesman_id = o.salesman_id) �����
  FROM orders_ex o;
---------------------------------------------------------------------------------
-- (5-3) ��ձ޿����� ���� �޴� ������ �ִ� �μ��� �μ���ȣ�� �μ��� ��ȸ
SELECT department_id, department_name
  FROM departments d
 WHERE EXISTS (SELECT department_id
                 FROM employees e
                WHERE e.department_id = d.department_id
                  AND salary > ( SELECT AVG(salary)
                                   FROM employees));
---------------------------------------------------------------------------------
-- 6. ������ �ִ� �������� ���
-- (6-1) parent_id�� 90�� �μ��� ���ϴ� �μ��� ��ձ޿����� ���� �޴�
-- ����� �����ȣ, �����, �μ���ȣ, �μ��� ��ȸ
-- (1) parent_id�� 90�� �μ��� ���ϴ� ��� ������� ��ձ޿� ��ȸ
SELECT FLOOR(AVG(salary))
  FROM employees e, departments d
 WHERE e.department_id = d.department_id
   AND parent_id = 90;
---------------------------------------------------------------------------------
-- (2) ���� SQL�� ��� ����   
CREATE OR REPLACE VIEW avg_view AS
SELECT FLOOR(AVG(salary)) avgsal
  FROM employees e, departments d
 WHERE e.department_id = d.department_id
   AND parent_id = 90;
---------------------------------------------------------------------------------
-- (3) ���� SQL �ۼ�
SELECT e.employee_id, e.emp_name, e.salary, d.department_id, d.department_name
  FROM employees e, departments d, avg_view v
 WHERE e.department_id = d.department_id
   AND e.salary > v.avgsal;
---------------------------------------------------------------------------------
-- (6-2) orders_ex, customer_ex �� ���� ���Ͽ�
-- ���ڽ��� ��� �ֹ��ݾ׺��� ū �ֹ��ݾ��� ���� ��� �ֹ� ��ȸ
-- (1) �� ���� ����ֹ��ݾ� ��ȸ
SELECT cust_name, FLOOR(AVG(purch_amt))
  FROM customer_ex c, orders_ex o
 WHERE c.customer_id = o.customer_id
GROUP BY cust_name;
---------------------------------------------------------------------------------
-- (2) orders_ex, ����並 ������ ��ձݾ׺��� ū �ֹ��ݾ� ��ȸ
SELECT o.customer_id, o.purch_amt ���űݾ�
  FROM orders_ex o, (SELECT customer_id, TRUNC(AVG(purch_amt)) avgpurch
                       FROM orders_ex
                   GROUP BY customer_id) tmp
WHERE o.customer_id = tmp.customer_id
  AND o.purch_amt > tmp.avgpurch
ORDER BY o.customer_id;
---------------------------------------------------------------------------------
-- (6-3) ������ NewYork�� �����ϴ� ���� ������� �̻��� ���� ������ ���� ��ȸ
-- �������̺� : customer_ex
-- (1) ���� ���� ������� ��ȸ
SELECT AVG(grade)
  FROM customer_ex
 WHERE city = 'New York';
---------------------------------------------------------------------------------
-- (2) ���� ����������� ū ������ ���� ��ȸ
SELECT grade, count(*)
  FROM customer_ex
 WHERE grade > ( SELECT AVG(grade)
                   FROM customer_ex
                  WHERE city = 'New York')
GROUP BY grade;
---------------------------------------------------------------------------------
-- (6-4) orders_ex���̺��� �����ᰡ ���� ū ��������� ���� ��� �ֹ����� ��ȸ
-- (1) ��������� �ִ� ������ ��ȸ
SELECT MAX(commision)
  FROM salesman;
---------------------------------------------------------------------------------
-- (1-1) ���������� �̿��� �ִ� �����Ḧ �޴� ������� ��ȸ
SELECT *
  FROM salesman
 WHERE commision = ( SELECT MAX(commision)
                      FROM salesman);
---------------------------------------------------------------------------------                      
-- (2) orders_ex���̺��� �ִ� �����Ḧ �޴� ����������� ��� �ֹ����� ��ȸ 
SELECT *
  FROM orders_ex
 WHERE salesman_id = ANY ( SELECT salesman_id
                             FROM salesman
                            WHERE commision = ( SELECT MAX(commision)
                             FROM salesman));