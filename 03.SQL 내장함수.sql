-- 1. �����Լ�
-- 1.1 CEIL(n) (�Ҽ��� ���� �� �������� ū ������ ��ȯ)
SELECT CEIL(10.123), CEIL(10.541), CEIL(11.01) FROM DUAL;

-- 1.2 FLOOR(n) (�Ҽ��� ������ ������ ��ȯ)
SELECT FLOOR(10.123), FLOOR(10.541), FLOOR(11.01) FROM DUAL;

-- 1.3 ROUND(n) (�ݿø�)
SELECT ROUND(10.123), ROUND(10.541), ROUND(11.01) FROM DUAL; 

-- 1.4 ROUND(n, i) (�Ҽ��� �ݿø�) (�޸� ���� ���� �ڸ����� �� �Ҽ����� �ݿø�(������ ������ �ڸ���))
SELECT ROUND(10.123, 1), ROUND(10.541, 2), ROUND(11.015, 3) FROM DUAL; 
SELECT ROUND(10.123, -1), ROUND(153.541, -2), ROUND(194.015, -3) FROM DUAL; 

-- 1.5 TRUNC(n1, n2) (�� ����) (�޸� ���� ���� �ڸ����� �� ���� ����)
SELECT TRUNC(115.155), TRUNC(115.155, 2), TRUNC(115.155, -1), TRUNC(115.155, -2) FROM DUAL;

-- 1.6 POWER(n1, n2) (�� ����) (�޸� ���� ����ŭ �޸� ���� ���� ����)
SELECT POWER(3, 2), POWER(3, 3), POWER(3, 4) FROM DUAL;

-- 1.7 MOD(n1, n2) (������) (�޸� �տ� ���� �޸� ���� ���� ���� ������ �� ��ȯ)
SELECT MOD(19, 4), MOD(19.123, 4.2) FROM DUAL;

-- 2. �����Լ�
-- 2.1 INITCAP(char) (ù ���ڸ� �빮�ڷ�, �������� �ҹ��ڷ� ��ȯ (������ �������� �����ν�)) 
SELECT INITCAP('never say goodbye') FROM DUAL;

-- 2.2 LOWER(char) (��� ���ڸ� �ҹ��ڷ� ��ȯ)
--     UPPER(char) (��� ���ڸ� �빮�ڷ� ��ȯ)
SELECT LOWER('HI, ITS MINSU'), UPPER('hi, its minsu') FROM DUAL;

-- 2.3 CONCAT(char1, char2) (�� ���ڿ��� �ٿ��� ��ȯ)
SELECT CONCAT('I Have', ' a Dream'), 'This is' || ' Minsu'FROM DUAL;

-- 2.4 SUBSTR(char, pos, length) (char���ڿ����� pos��° ���ڿ����� length��ŭ �߶� ��ȯ)
SELECT SUBSTR('ABCDEFG', 1, 5), SUBSTR('ABCDEFGHI', -7, 3) FROM DUAL;
SELECT SUBSTR('�����ٶ󸶹ٻ�', 3, 3), SUBSTR('�����ٶ󸶹ٻ�', -3, 3) FROM DUAL;

-- 2.5 SUBSTRB(char, pos, length) -- ����Ŭ���� �ѱ� 1���ڴ� 3����Ʈ�� ����
--     (����Ʈ�� �������� char���ڿ����� pos��° ���ڿ����� length��ŭ �߶� ��ȯ)
SELECT SUBSTRB('ABCDEFG', 1, 4), SUBSTRB('�����ٶ󸶹ٻ�', 1, 4) FROM DUAL;

-- 2.6 LTRIM(char, set) (���ڿ����� set�� ������ ���ڿ��� ���ʿ��� ����)
--     RTRIM(char, set) (���ڿ����� set�� ������ ���ڿ��� �����ʿ��� ����)
SELECT LTRIM('ABCDEFGABC', 'ABC'), LTRIM('     �����ٶ�', ' '), 
       RTRIM('ABCDEFGABC', 'ABC'), RTRIM('     �����ٶ�', '��') FROM DUAL;
       
-- 2.7 LPAD(char1, n, char2) (char2���ڿ��� char1���ڿ� ���ʿ� �ٿ��� n�� ���ڿ��� ��ȯ)
--     RPAD(char1, n, char2) (char2���ڿ��� char1���ڿ� �����ʿ� �ٿ��� n�� ���ڿ��� ��ȯ)
SELECT LPAD('111-1111', 12, '(02)'),
       RPAD('111-1111', 12, '(02)') FROM DUAL;
       
-- SQL �������� 1
-- CUSTOMERS���̺� cust_main_phone_number�÷����� �� ���ڸ��� �����ϰ� (02)�� �ٿ��� ����, ��ȣ ��ȸ
-- SELECT LTRIM('620-736-1008', '620-'), LPAD('736-1008', 12, '(02)') FROM DUAL;
SELECT cust_name, LPAD(SUBSTR(cust_main_phone_number, 5), 12, '(02)') FROM customers;

-- 2.8 REPLACE(char, str1, str2) (char���ڿ����� str1�����ڿ��� str2�� ��ȯ
SELECT REPLACE('ABC/DEF~GHI', '/', '~') FROM DUAL;

-- 2.9 TRANSLATE(char, from, to) (from�� ���ڿ��� to�� ���ڿ��� �ϳ��� �����Ͽ� ��ȯ)
SELECT TRANSLATE('PROGRAMING', 'PRM', 'ONB') FROM DUAL;

-- 2.10 INSTR(str, substr, pos)
-- (str���ڿ����� pos��° ���ڿ��� �������� substr�� ��ġ�ϴ� ������ ��ġ�� ��ȯ)
SELECT INSTR('prefix, precise, preface', 'pre', 3) AS INSTR1 FROM DUAL;
SELECT INSTR('prefix, precise, preface', 'pre', 7, 2) AS INSTR1 FROM DUAL;

-- 2.11 LENGTH(char) (���ڿ��� ������ ��ȯ)
--      LENGTHB(char) (���ڿ��� ����Ʈ���� ��ȯ)
SELECT LENGTH('���ѹα�'), LENGTHB('���ѹα�') FROM DUAL;

-- SQL �������� 2
-- EMPLOYEES���̺��� hire_date�� ������ �������ڸ� �������� �ټӳ���� 20�� �̻��� 
-- ����� �����ȣ, �����, �Ի�����, �ټӳ�� ��ȸ
SELECT employee_id, emp_name, hire_date, TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12) �ټӳ��
FROM employees
WHERE MONTHS_BETWEEN(sysdate, hire_date)>=240
ORDER BY hire_date;

SELECT employee_id, emp_name, hire_date, SUBSTR(sysdate, 1, 4)-SUBSTR(hire_date, 1, 4) �ټӳ��
FROM employees
WHERE SUBSTR(sysdate, 1, 4)-SUBSTR(hire_date, 1, 4)>=20
ORDER BY hire_date;

-- 3. ��¥�Լ�
-- 3.1 SYSDATE, SYSTIMESTAMP
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

-- 3.2 ADD_MONTHS(date, integer) (date��¥�� integer��ŭ�� ���� ���� ��¥�� ��ȯ)
SELECT ADD_MONTHS(SYSDATE, 1), ADD_MONTHS(SYSDATE, -1) FROM DUAL;

-- 3.3 MONTHS_BETWEEN(date1, date2) (�� ��¥ ������ ������ ��ȯ)
SELECT MONTHS_BETWEEN('2019-03-16', '2019-12-16') FROM DUAL;

-- 3.4 LAST_DAY(date) (date��¥�� �������� �ش� ���� ������ ���ڸ� ��ȯ)
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- 3.5 ROUND(date, format) (format�� ���� �ݿø��� ��¥�� ��ȯ)
--     TRUNC(date, format) (format�� ���� ���� ��¥�� ��ȯ)
SELECT SYSDATE, ROUND(SYSDATE, 'month'), TRUNC(SYSDATE, 'month') FROM DUAL;

-- 3.6 NEXT DAY(date, day) (date��¥�� �������� ������ �ٰ��� day�� ����� ������ ��ȯ)
SELECT NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;

-- SQL �������� 3
-- EMPLOYEES���̺��� employee_id, emp_name, hire_date, ���Ĺ߷��� ��ȸ
-- hire_date�� �������� 3���� �� ù��° �������� ������ �߷ɳ�¥��
SELECT employee_id, emp_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date, 3), '������') ���Ĺ߷���
FROM employees
ORDER BY hire_date;

-- 4. ��ȯ�Լ�
-- 4.1 TO_CHAR(����/��¥, format) (���� �Ǵ� ��¥�� ���ڷ� ��ȯ���ִ� �Լ�)
SELECT TO_CHAR(123456789, '999,999,999') FROM DUAL;
SELECT TO_CHAR(sysdate, 'AM') FROM DUAL;
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(sysdate, 'DD') FROM DUAL;

-- 4.2 TO_NUMBER() (���ڳ� ���ڸ� NUMBER������ ��ȯ)
SELECT TO_NUMBER('123456') FROM DUAL;

-- 4.3 TO_DATE(char, format) (���ڸ� ��¥������ ��ȯ)
--     TO_TIMESTAMP(char, format) (���ڸ� ��¥������ ��ȯ)
SELECT TO_DATE('20140101', 'YYYY-MM-DD') FROM DUAL;
SELECT TO_TIMESTAMP('20140101', 'YYYY-MM-DD') FROM DUAL;

-- 5. NULL�Լ�
-- 5.1 NVL(expr1, expr2) (expr1�� null�̸� expr2�� ��ȯ) (NullValue)
SELECT NVL(manager_id, employee_id) FROM employees WHERE manager_id IS NULL;

-- SQL �������� 4
-- EMPLOYEES���̺��� employee_id, commission_pct�� ��ȸ commission_pct���� null�̸� 0���� ��ȯ
SELECT employee_id, NVL(commission_pct, 0)
FROM employees
ORDER BY commission_pct;

-- 5.2 NVL2(expr1, expr2, expr3) (expr1�� null�� �ƴϸ� expr2��, null�̸� expr3�� ��ȯ)
SELECT employee_id, salary, NVL2(commission_pct, salary+(salary*commission_pct), salary) final
FROM employees
ORDER BY commission_pct;

-- 5.3 COALESCE(expr1, expr2...) (���� NULL�� �ƴ� ù ǥ������ ��ȯ)
SELECT employee_id, salary, commission_pct,
COALESCE(salary * commission_pct, 0) commission_fee
FROM employees
ORDER BY commission_pct;

-- 5.4 LNNVL(���ǽ�) (���ǽĿ� �ݴ�Ǵ� ���� ��ȸ)
SELECT COUNT (*) FROM employees
WHERE(commission_pct >= 0.2); -- Ŀ�̼��� 0.2�̻��� ���
--<-> 
SELECT COUNT (*) FROM employees
WHERE LNNVL(commission_pct >= 0.2); -- Ŀ�̼��� 0.2�̻��� �ƴ� ���
-- ==
SELECT COUNT (*) FROM employees
WHERE commission_pct < 0.2 OR commission_pct IS NULL; -- Ŀ�̼��� 0.2�̻��� �ƴ� ���

-- 5.5 NULLIF(expr1, expr2) (expr1�� expr2�� ���� ������ NULL, �ٸ��� expr1�� ��ȯ)
SELECT employee_id, job_id, start_date, end_date,
       NULLIF(TO_CHAR(end_date,'YYYY'), TO_CHAR(start_date,'YYYY')) ��å����
FROM job_history;

-- 6. ��Ÿ�Լ�
-- 6.1 GREATEST(expre1, expr2...) (expr�� ���� ū ���� ��ȯ)
--     LEAST(expre1, expr2...) (expr�� ���� ���� ���� ��ȯ)
SELECT GREATEST('�̼���', '������', '�������'), LEAST('�̼���', '������', '�������')
FROM DUAL;

-- 6.2 DECODE(expr, search1, result1...)(expr�� search1�� ���� ���� ������ result1,
--            �ٸ��� �ٽ� search2�� ���� ������ result2, ���������� ���� ���� ������ default�� ��ȯ
SELECT cust_id, prod_id, DECODE(channel_id, 2, 'Partners', 3, 'Direct Sales', 4, 'Internet',
       5, 'Catalog', 9, 'Tele Sales', 'Othes') AS �ǸŹ��
FROM sales;

-- SQL �������� 5
-- CUSTOMERS���̺��� ����, �������, ���븦 ��ȸ
-- ���� ��������� �о� �������ڸ� �������� 2~70�� ���� �����ؼ� ��ȸ
SELECT cust_name, cust_year_of_birth, DECODE(FLOOR((TO_CHAR(sysdate, 'YYYY')-cust_year_of_birth)/10),
       2, '20��', 3, '30��', 4, '40��', 5, '50��', 6, '60��', 7, '70��', '��Ÿ') AS ����
FROM customers
ORDER BY ����;

-- 7. �����Լ�
-- 7.1 COUNT(expr) (���� �� ��ȯ)
SELECT COUNT(*) FROM employees;
SELECT COUNT(employee_id) FROM employees;
SELECT COUNT(department_id) FROM employees;
SELECT COUNT(DISTINCT(department_id)) FROM employees;

-- 7.2 SUM(expr) (��ü �հ� ��ȯ)
SELECT SUM(salary) FROM employees;

-- 7.3 AVG(expr) (��ü�� ��հ� ��ȯ)
SELECT AVG(salary) FROM employees;

-- 7.4 MAX(expr) (�ִ밪 ��ȯ)
--     MIN(expr) (�ּҰ� ��ȯ)
SELECT MIN(salary), MAX(salary) FROM employees;

-- 8. ���տ����� (�ΰ� �̻��� ������ ������ �ϳ��� ������ ����� ����)
CREATE  TABLE  exp_goods_asia (
  country VARCHAR2(10),
  seq     NUMBER,
  goods   VARCHAR2(80)
);

INSERT INTO exp_goods_asia VALUES('�ѱ�', 1, '�������� ������');
INSERT INTO exp_goods_asia VALUES('�ѱ�', 2, '�ڵ���');
INSERT INTO exp_goods_asia VALUES('�ѱ�', 3, '��������ȸ��');
INSERT INTO exp_goods_asia VALUES('�ѱ�', 4, '����');
INSERT INTO exp_goods_asia VALUES('�ѱ�', 5, 'LCD');
INSERT INTO exp_goods_asia VALUES('�ѱ�', 6, '�ڵ�����ǰ');
INSERT INTO exp_goods_asia VALUES('�ѱ�', 7, '�޴���ȭ');
INSERT INTO exp_goods_asia VALUES('�ѱ�', 8, 'ȯ��źȭ����');
INSERT INTO exp_goods_asia VALUES('�ѱ�', 9, '�����۽ű� ���÷��� �μ�ǰ');
INSERT INTO exp_goods_asia VALUES('�ѱ�', 10, 'ö �Ǵ� ���ձݰ�');

INSERT INTO exp_goods_asia VALUES('�Ϻ�', 1, '�ڵ���');
INSERT INTO exp_goods_asia VALUES('�Ϻ�', 2, '�ڵ�����ǰ');
INSERT INTO exp_goods_asia VALUES('�Ϻ�', 3, '��������ȸ��');
INSERT INTO exp_goods_asia VALUES('�Ϻ�', 4, '����');
INSERT INTO exp_goods_asia VALUES('�Ϻ�', 5, '�ݵ�ü������');
INSERT INTO exp_goods_asia VALUES('�Ϻ�', 6, 'ȭ����');
INSERT INTO exp_goods_asia VALUES('�Ϻ�', 7, '�������� ������');
INSERT INTO exp_goods_asia VALUES('�Ϻ�', 8, '�Ǽ����');
INSERT INTO exp_goods_asia VALUES('�Ϻ�', 9, '���̿���, Ʈ��������');
INSERT INTO exp_goods_asia VALUES('�Ϻ�', 10, '����');
commit;
-- (1) ���տ������� ��ȸ�÷��� ������ Ÿ���� ��ġ�ؾ��Ѵ�.
-- (2) ORDER BY�� ���� ������ ���忡���� ����� �� �ִ�.

-- 8.1 UNION (�ߺ��� ������ ������)
SELECT goods FROM exp_goods_asia
WHERE country = '�ѱ�'
UNION
SELECT goods FROM exp_goods_asia
WHERE country = '�Ϻ�';

-- 8.2 UNION ALL (�ߺ��� ������ ������)
SELECT goods FROM exp_goods_asia
WHERE country = '�ѱ�'
UNION ALL
SELECT goods FROM exp_goods_asia
WHERE country = '�Ϻ�';

-- 8.3 INTERSECT (������)
SELECT goods FROM exp_goods_asia
WHERE country = '�ѱ�'
intersect
SELECT goods FROM exp_goods_asia
WHERE country = '�Ϻ�';

-- 8.4 MINUS (������)
SELECT goods FROM exp_goods_asia
WHERE country = '�ѱ�'
MINUS
SELECT goods FROM exp_goods_asia
WHERE country = '�Ϻ�';

-- SQL �������� 6
-- employees���̺��� �Ի�⵵�� ������� ���Ͻÿ�
SELECT TO_CHAR(hire_date, 'YYYY') AS �Ի�⵵, count(*) AS �����
FROM employees
GROUP BY TO_CHAR(hire_date, 'YYYY');

-- SQL �������� 7
-- kor_loan_status���̺��� 2012�⵵ ����, ������, �����Ѿ� ��ȸ
SELECT distinct period, region, SUM(loan_jan_amt)
FROM kor_loan_status
WHERE period LIKE '2012%'
GROUP BY period, region
ORDER BY period;

-- SQL �������� 8
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY period, ROLLUP(gubun);

-- �� ������ ���տ����ڸ� ����� ������ �ٲٽÿ�

-- (1) ����, ����, ���� �Ѿ� ��ȸ
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY period, gubun
ORDER BY period;

--(2) 2013�� ���� �����Ѿ� ��ȸ
SELECT period, '', SUM(loan_jan_amt)
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY period
UNION
SELECT period, '', SUM(loan_jan_amt)
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY period;