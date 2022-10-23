-- 1. ���̺� ���� �� DDL ���
CREATE TABLE ex1(
  column1 CHAR(10),
  column2 VARCHAR2(10),
  column3 NUMBER
);

CREATE TABLE ex2(
  column1 CHAR(10),
  column2 VARCHAR2(10),
  column3 NUMBER NOt NULL
);

CREATE TABLE ex3(
  column1 CHAR(10),
  column2 VARCHAR2(10),
  column3 NUMBER UNIQUE
);

CREATE TABLE ex4(
  column1 CHAR(10),
  column2 VARCHAR2(10),
  column3 NUMBER PRIMARY KEY
);

CREATE TABLE ex5(
  column1 CHAR(10),
  column2 VARCHAR2(10),
  column3 NUMBER,
  CONSTRAINT column3_fk FOREIGN KEY(column3)
  REFERENCES ex4(column3)
);

CREATE TABLE ex6(
  column1 CHAR(10),
  column2 VARCHAR2(10),
  column3 NUMBER,
  CONSTRAINT check1 CHECK(column3 BETWEEN 0 AND 10)
);

CREATE TABLE ex7 (); -- ���̺� ����
DROP TABLE ex6 cascade constraints; -- ���̺� ����
ALTER TABLE ex5 RENAME COLUMN column3 TO column4; -- DDL��� �÷��� ����
ALTER TABLE ex5 MODIFY column1 VARCHAR2(30); -- DDL��� �÷�Ÿ�� ����
ALTER TABLE ex5 ADD column3 NUMBER; -- DDL��� �÷� �߰�
ALTER TABLE ex5 DROP COLUMN column4; -- DDL��� �÷� ����
ALTER TABLE ex5 ADD CONSTRAINTS column1_pk PRIMARY KEY(column1); -- DDL��� �⺻Ű �߰�
ALTER TABLE ex5 DROP CONSTRAINTS column1_pk; -- DDL��� �⺻Ű ����

CREATE TABLE ex6 AS                -- ���̺� ����
  SELECT column1, column2, column3
    FROM ex1;

-- 2. ��(VIEW)
-- ��� ���� ���̺��� �����ϴ� ���� �ƴ�, ���� ���̺�κ��� �ۼ��Ǵ� ���� ���̺��̴�.
-- ���̺� �Ӹ� �ƴ϶� �並 ������ �� �ٸ� �並 ���� �� �ִ�.
-- (1) customers���̺�κ��� cust_view��� ��(������ ���̺�)�� ����
CREATE OR REPLACE VIEW cust_view AS
  SELECt cust_id, cust_name, cust_gender, cust_city
    FROM customers;
  SELECT * FROM cust_view;
-- (2) �並 �����ϴ� ���̺� ��ȸ
SELECT * FROM user_views; -- �並 �����ϴ� ���̺�
-- (3) �� ����
DROP VIEW cust_view;

-- 3. ������
-- ������ �ڵ����� �ٲ�� ���
-- (1) ������ ����
CREATE SEQUENCE ex1_seq
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 999999
NOCYCLE
NOCACHE;
-- (2) ������ ����
DROP SEQUENCE ex1_seq;

-- 4. ��Ƽ�� ���̺�
-- 4-1 RANGE ��Ƽ�� ���̺�
CREATE TABLE mypart(
  my_no NUMBER,
  my_year NUMBER NOT NULL,
  my_month NUMBER NOT NULL,
  my_day NUMBER NOT NULL,
  my_value NUMBER NOT NULL
)
PARTITION BY RANGE(my_year, my_month, my_day) -- ����� 3���� �������� ���̺��� ����
(
  PARTITION my_q1 VALUES LESS THAN(2019, 07, 01),
  PARTITION my_q2 VALUES LESS THAN(2020, 01, 01),
  PARTITION my_q3 VALUES LESS THAN(2020, 07, 01)
);
INSERT INTO mypart VALUES(1, 2019, 01, 03, 00);
INSERT INTO mypart VALUES(2, 2020, 05, 03, 00);
INSERT INTO mypart VALUES(3, 2020, 01, 03, 00);
INSERT INTO mypart VALUES(4, 2019, 06, 03, 00);
INSERT INTO mypart VALUES(5, 2020, 11, 13, 00);
INSERT INTO mypart VALUES(6, 2020, 06, 30, 00);
INSERT INTO mypart VALUES(7, 2019, 08, 21, 00);
commit;
SELECT * FROM mypart PARTITION(my_q1); -- ��Ƽ������ ���ϴ� ���̺��� ���� �б�
SELECT * FROM mypart PARTITION(my_q2);
SELECT * FROM mypart PARTITION(my_q3);

-- 4-2. LIST ��Ƽ�� ���̺� ����
CREATE TABLE EMP_LIST_PT (
  EMP_NO NUMBER NOT NULL,
  ENAME VARCHAR2(20),
  JOB VARCHAR2(20),
  MGR NUMBER(4),
  HIREDATE DATE,
  SAL NUMBER(7,2),
  COMM NUMBER(7,2),
  DEPT_NO NUMBER(2)
)
PARTITION BY LIST(JOB)
(
  PARTITION EMP_LIST_PT1 VALUES ('MANAGER'),
  PARTITION EMP_LIST_PT2 VALUES ('SALESMAN'),
  PARTITION EMP_LIST_PT3 VALUES ('ANALYST'),
  PARTITION EMP_LIST_PT4 VALUES ('PRESIDENT', 'CLERK')
);
INSERT INTO emp_list_pt VALUES(1, 'SMITH',  'CLERK',     7902, SYSDATE,  800, NULL, 20);
INSERT INTO emp_list_pt VALUES(2, 'ALLEN',  'SALESMAN',  7698, SYSDATE, 1600,  300, 30);
INSERT INTO emp_list_pt VALUES(3, 'WARD',   'SALESMAN',  7698, SYSDATE, 1250,  500, 30);
INSERT INTO emp_list_pt VALUES(4, 'JONES',  'MANAGER',   7839, SYSDATE,  2975, NULL, 20);
INSERT INTO emp_list_pt VALUES(5, 'MARTIN', 'SALESMAN',  7698, SYSDATE, 1250, 1400, 30);
INSERT INTO emp_list_pt VALUES(6, 'BLAKE',  'MANAGER',   7839, SYSDATE,  2850, NULL, 30);
INSERT INTO emp_list_pt VALUES(7, 'CLARK',  'MANAGER',   7839, SYSDATE,  2450, NULL, 10);
INSERT INTO emp_list_pt VALUES(8, 'SCOTT',  'ANALYST',   7566, SYSDATE, 3000, NULL, 20);
INSERT INTO emp_list_pt VALUES(9, 'KING',   'PRESIDENT', NULL, SYSDATE, 5000, NULL, 10);
INSERT INTO emp_list_pt VALUES(10, 'TURNER', 'SALESMAN',  7698,SYSDATE,  1500,    0, 30);
INSERT INTO emp_list_pt VALUES(11, 'ADAMS', 'CLERK', 7788,SYSDATE,1100,NULL,20);
INSERT INTO emp_list_pt VALUES(12, 'JAMES',  'CLERK',     7698, SYSDATE,   950, NULL, 30);
INSERT INTO emp_list_pt VALUES(13, 'FORD',   'ANALYST',   7566, SYSDATE,  3000, NULL, 20);
INSERT INTO emp_list_pt VALUES(14, 'MILLER', 'CLERK',     7782,  SYSDATE, 1300, NULL, 10);
commit;
-- ��ü ������ ��ȸ
SELECT * FROM emp_list_pt;
-- ��Ƽ���� �����ϴ� ���̺� ��ȸ��
SELECT * FROM ALL_TAB_PARTITIONS; -- ��Ƽ���� �����ϴ� ���̺�
-- Ư�� ��Ƽ�ǿ��� ������ ��ȸ
SELECT * FROM emp_list_pt PARTITION(emp_list_pt1);
SELECT * FROM emp_list_pt PARTITION(emp_list_pt2);
SELECT * FROM emp_list_pt PARTITION(emp_list_pt3);
SELECT * FROM emp_list_pt PARTITION(emp_list_pt4);
-- ��Ƽ�� ����
ALTER TABLE emp_list_pt DROP PARTITION emp_list_pt1;
ALTER TABLE emp_list_pt DROP PARTITION emp_list_pt2;
ALTER TABLE emp_list_pt DROP PARTITION emp_list_pt3;
ALTER TABLE emp_list_pt DROP PARTITION emp_list_pt4;
DROP TABLE emp_list_pt CASCADE CONSTRAINTS;