-- SQL DML
-- 1. SELECT
-- (1) WHERE��1 OR ��� - �� �� �ϳ��� �ش��ϸ�
SELECT employee_id, emp_name
  FROM employees
 WHERE salary>3000 OR job_id='ST_CLERK'
ORDER BY employee_id;

-- (2) WHERE�� AND ��� - �� �� �ش��ϸ�
SELECT employee_id, emp_name
  FROM employees
 WHERE salary>3000 AND job_id='ST_CLERK'
ORDER BY employee_id;

-- (3) WHERE�� LIKE ��� - %�� �����ϸ� 
SELECT employee_id, emp_name
  FROM employees
 WHERE emp_name LIKE 'S%'
ORDER BY emp_name;

-- (4) WHERE�� IN ��� - �ش��ϴ� ���ǿ� �ϳ��� �ش��ϸ�
SELECT department_id, employee_id, emp_name
  FROM employees
 WHERE department_id IN(30, 50, 90)
ORDEr BY department_id;

-- (5) WHERE�� BETWEEN ~ AND ���
SELECT SUM(amount_sold)
  FROM sales
 WHERE sales_month BETWEEN '199801' AND '199812';
 
-- (6) DISTINCT ��� - �ߺ��Ǵ� �� ����
SELECT DISTINCT cust_city 
  FROM customers
 WHERE country_id = '52778';
 
-- (7) GROUP BY ��� - �׷����� ���� ���賻�� �� ���
SELECT cust_city, count(cust_city)
  FROM customers
 WHERE country_id = '52778'
GROUP BY cust_city;

-- (8) GROUP BY ~ HAVING ��� - �׷��� ���� ���ÿ� WHEREó�� ���� �߰�
SELECT cust_city, count(cust_city)
  FROM customers
GROUP BY cust_city
HAVING count(cust_city) >= 500;

-- 2. INSERT
CREATE TABLE ex3(
  emp_id NUMBER,
  emp_name VARCHAR2(80),
  salary NUMBER,
  manager_id NUMBER
);

-- (1) �ٸ� ���̺�κ��� ��ȸ �� INSERT
INSERT INTO ex2
SELECT employee_id, emp_name, salary, manager_id
  FROM employees;
  
-- (2) ���� �Ȱ��� ���̺� ���� �� EMPLOYEE���̺��� ������ ����� 124�̰�
-- �޿��� 2000~3000�� ����� ��ȸ �� ex3���̺� INSERT
INSERT INTO ex3
SELECT employee_id, emp_name, salary, manager_id
  FROM employees
 WHERE manager_id = 124 AND salary BETWEEN 2000 AND 3000;
 
-- 3. UPDATE
-- (1) ex3���̺��� �����ȣ�� 198�� ����� �޿��� 3500���� ����
UPDATE ex3
   SET salary = 3500
 WHERE emp_id = 198;
 
-- 4. DELETE
-- (1) ex3���̺��� �����ȣ�� 198���� ��� ����
DELETE ex3
 WHERE emp_id = 198;
 
-- 5. MERGE - �����ϴ� ������ ���� UPSERT ����

-- 6. �ǻ��÷� 
-- 6-1 ROWRUM (������ ���ڵ� ����ŭ ��ȸ�� �� ���)
SELECT ROWNUM, employee_id, emp_name
  FROM employees
  WHERE ROWNUM <=10;
  
-- 6-2 ROWID(�࿡ id�� �������ִµ� �� �ּҰ��� ��Ÿ��. ���� �ĺ��ϴ� ������ ��)
-- �ߺ��� �����͸� ���� ���̺��� ROWID�� �̿��� Ư�� �����͸� ����

-- 7. ������
-- 7-1. * - ���

-- 7-2. || - JAVA�� ��¿��� +�� ���� ����

-- 7-3. ���ǿ�����
-- 7-3-1. CASE ~ END ������ - ��캰�� ������ ����
-- (1) EMPLOYEES���̺��� �޿��� ����� ������ �����ȣ, �����, �޿�, �޿���� ��ȸ
SELECT employee_id, emp_name, salary,
CASE WHEN salary < 5000 THEN 'C���'
     WHEN salary BETWEEN 5000 AND 15000 THEN 'B���'
     ELSE 'A���'
END
AS �޿����
  FROM employees
ORDER BY salary desc;

-- (2) EMPLOYEES���̺��� �����ȣ, �����, job_id, �޿�, �λ�ȱ޿� ��ȸ
-- CASE1 job_id�� ST_MAN�̸� �λ�� �޿��� �޿�1*1 ����
-- CASE2 SA_REP�� �޿�*1.05 ����
-- CASE3 FI_ACCOUNT�� �޿�*1 ����
-- ELSE �޿�*1.03 ����
SELECT employee_id, emp_name, salary,
  CASE WHEN job_id = 'SA_REP' THEN salary*1.05
       WHEN job_id = 'FI_ACCOUNT' THEN salary*1.03
       ELSE salary*1
END
AS raisedsalary
FROM employees
ORDER BY raisedsalary desc;

-- 7-3-2. ANY ������ - IN�� ��������� �� �پ��� Ȱ�� ����
-- (1) CUSTOMERS���̺��� ���ֵ��ð� CA, CO, AR�� �ϳ��� ���� ����, ���Ե��, �ָ� ��ȸ
SELECT cust_id, cust_name, cust_income_level, cust_state_province
  FROM customers
 WHERE cust_state_province = ANY('CA', 'CO', 'AR');
 
-- 7-3-3. ALL ������ - ��ȣ ���� ������ ��� �����ϴ� ���
-- (1) EMPLOYEES���̺��� job_id�� 'SA_MAN'�� �������
-- �޿��� ���� �޴� ����� �����, job_id,salary ��ȸ
SELECT emp_name, job_id, salary
  FROM employees
 WHERE salary > ALL(SELECT salary FROM employees WHERE job_id='ST_MAN')
   --AND job_id <> 'SA_MAN';