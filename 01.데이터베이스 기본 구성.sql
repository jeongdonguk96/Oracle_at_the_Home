-- 1. 테이블 생성 및 DDL 사용
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

CREATE TABLE ex7 (); -- 테이블 생성
DROP TABLE ex6 cascade constraints; -- 테이블 삭제
ALTER TABLE ex5 RENAME COLUMN column3 TO column4; -- DDL사용 컬럼명 수정
ALTER TABLE ex5 MODIFY column1 VARCHAR2(30); -- DDL사용 컬럼타입 수정
ALTER TABLE ex5 ADD column3 NUMBER; -- DDL사용 컬럼 추가
ALTER TABLE ex5 DROP COLUMN column4; -- DDL사용 컬럼 삭제
ALTER TABLE ex5 ADD CONSTRAINTS column1_pk PRIMARY KEY(column1); -- DDL사용 기본키 추가
ALTER TABLE ex5 DROP CONSTRAINTS column1_pk; -- DDL사용 기본키 삭제

CREATE TABLE ex6 AS                -- 테이블 복사
  SELECT column1, column2, column3
    FROM ex1;

-- 2. 뷰(VIEW)
-- 뷰는 실제 테이블을 생성하는 것이 아닌, 실제 테이블로부터 작성되는 가상 테이블이다.
-- 테이블 뿐만 아니라 뷰를 참조해 또 다른 뷰를 만들어낼 수 있다.
-- (1) customers테이블로부터 cust_view라는 뷰(가상의 테이블)를 생성
CREATE OR REPLACE VIEW cust_view AS
  SELECt cust_id, cust_name, cust_gender, cust_city
    FROM customers;
  SELECT * FROM cust_view;
-- (2) 뷰를 관리하는 테이블 조회
SELECT * FROM user_views; -- 뷰를 관리하는 테이블
-- (3) 뷰 삭제
DROP VIEW cust_view;

-- 3. 시퀀스
-- 순번이 자동으로 바뀌는 기능
-- (1) 시퀀스 생성
CREATE SEQUENCE ex1_seq
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 999999
NOCYCLE
NOCACHE;
-- (2) 시퀀스 삭제
DROP SEQUENCE ex1_seq;

-- 4. 파티션 테이블
-- 4-1 RANGE 파티션 테이블
CREATE TABLE mypart(
  my_no NUMBER,
  my_year NUMBER NOT NULL,
  my_month NUMBER NOT NULL,
  my_day NUMBER NOT NULL,
  my_value NUMBER NOT NULL
)
PARTITION BY RANGE(my_year, my_month, my_day) -- 년월일 3개를 기준으로 테이블을 나눔
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
SELECT * FROM mypart PARTITION(my_q1); -- 파티션으로 원하는 테이블을 묶어 읽기
SELECT * FROM mypart PARTITION(my_q2);
SELECT * FROM mypart PARTITION(my_q3);

-- 4-2. LIST 파티션 테이블 생성
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
-- 전체 데이터 조회
SELECT * FROM emp_list_pt;
-- 파티션을 관리하는 테이블 조회ㅇ
SELECT * FROM ALL_TAB_PARTITIONS; -- 파티션을 관리하는 테이블
-- 특정 파티션에서 데이터 조회
SELECT * FROM emp_list_pt PARTITION(emp_list_pt1);
SELECT * FROM emp_list_pt PARTITION(emp_list_pt2);
SELECT * FROM emp_list_pt PARTITION(emp_list_pt3);
SELECT * FROM emp_list_pt PARTITION(emp_list_pt4);
-- 파티션 삭제
ALTER TABLE emp_list_pt DROP PARTITION emp_list_pt1;
ALTER TABLE emp_list_pt DROP PARTITION emp_list_pt2;
ALTER TABLE emp_list_pt DROP PARTITION emp_list_pt3;
ALTER TABLE emp_list_pt DROP PARTITION emp_list_pt4;
DROP TABLE emp_list_pt CASCADE CONSTRAINTS;