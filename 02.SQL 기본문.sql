-- SQL DML
-- 1. SELECT
-- (1) WHERE에1 OR 사용 - 둘 중 하나라도 해당하면
SELECT employee_id, emp_name
  FROM employees
 WHERE salary>3000 OR job_id='ST_CLERK'
ORDER BY employee_id;

-- (2) WHERE에 AND 사용 - 둘 다 해당하면
SELECT employee_id, emp_name
  FROM employees
 WHERE salary>3000 AND job_id='ST_CLERK'
ORDER BY employee_id;

-- (3) WHERE에 LIKE 사용 - %를 포함하면 
SELECT employee_id, emp_name
  FROM employees
 WHERE emp_name LIKE 'S%'
ORDER BY emp_name;

-- (4) WHERE에 IN 사용 - 해당하는 조건에 하나라도 해당하면
SELECT department_id, employee_id, emp_name
  FROM employees
 WHERE department_id IN(30, 50, 90)
ORDEr BY department_id;

-- (5) WHERE에 BETWEEN ~ AND 사용
SELECT SUM(amount_sold)
  FROM sales
 WHERE sales_month BETWEEN '199801' AND '199812';
 
-- (6) DISTINCT 사용 - 중복되는 행 제거
SELECT DISTINCT cust_city 
  FROM customers
 WHERE country_id = '52778';
 
-- (7) GROUP BY 사용 - 그룹으로 묶어 집계내는 데 사용
SELECT cust_city, count(cust_city)
  FROM customers
 WHERE country_id = '52778'
GROUP BY cust_city;

-- (8) GROUP BY ~ HAVING 사용 - 그룹을 묶는 동시에 WHERE처럼 조건 추가
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

-- (1) 다른 테이블로부터 조회 후 INSERT
INSERT INTO ex2
SELECT employee_id, emp_name, salary, manager_id
  FROM employees;
  
-- (2) 위와 똑같은 테이블 생성 후 EMPLOYEE테이블에서 관리자 사번이 124이고
-- 급여가 2000~3000인 사원을 조회 후 ex3테이블에 INSERT
INSERT INTO ex3
SELECT employee_id, emp_name, salary, manager_id
  FROM employees
 WHERE manager_id = 124 AND salary BETWEEN 2000 AND 3000;
 
-- 3. UPDATE
-- (1) ex3테이블에서 사원번호가 198인 사원의 급여를 3500으로 변경
UPDATE ex3
   SET salary = 3500
 WHERE emp_id = 198;
 
-- 4. DELETE
-- (1) ex3테이블에서 사원번호가 198번인 사원 삭제
DELETE ex3
 WHERE emp_id = 198;
 
-- 5. MERGE - 지정하는 조건을 비교해 UPSERT 수행

-- 6. 의사컬럼 
-- 6-1 ROWRUM (정해진 레코드 수만큼 조회할 때 사용)
SELECT ROWNUM, employee_id, emp_name
  FROM employees
  WHERE ROWNUM <=10;
  
-- 6-2 ROWID(행에 id가 숨겨져있는데 그 주소값을 나타냄. 행을 식별하는 유일한 값)
-- 중복된 데이터를 가진 테이블에서 ROWID를 이용해 특정 데이터를 제거

-- 7. 연산자
-- 7-1. * - 모두

-- 7-2. || - JAVA의 출력에서 +와 같은 역할

-- 7-3. 조건연산자
-- 7-3-1. CASE ~ END 연산자 - 경우별로 나뉘어 연산
-- (1) EMPLOYEES테이블에서 급여로 등급을 나누어 사원번호, 사원명, 급여, 급여등급 조회
SELECT employee_id, emp_name, salary,
CASE WHEN salary < 5000 THEN 'C등급'
     WHEN salary BETWEEN 5000 AND 15000 THEN 'B등급'
     ELSE 'A등급'
END
AS 급여등급
  FROM employees
ORDER BY salary desc;

-- (2) EMPLOYEES테이블에서 사원번호, 사원명, job_id, 급여, 인상된급여 조회
-- CASE1 job_id가 ST_MAN이면 인상된 급여에 급여1*1 저장
-- CASE2 SA_REP면 급여*1.05 저장
-- CASE3 FI_ACCOUNT면 급여*1 저장
-- ELSE 급여*1.03 저장
SELECT employee_id, emp_name, salary,
  CASE WHEN job_id = 'SA_REP' THEN salary*1.05
       WHEN job_id = 'FI_ACCOUNT' THEN salary*1.03
       ELSE salary*1
END
AS raisedsalary
FROM employees
ORDER BY raisedsalary desc;

-- 7-3-2. ANY 연산자 - IN과 비슷하지만 더 다양한 활용 가능
-- (1) CUSTOMERS테이블에서 거주도시가 CA, CO, AR중 하나인 고객의 고객명, 수입등급, 주명 조회
SELECT cust_id, cust_name, cust_income_level, cust_state_province
  FROM customers
 WHERE cust_state_province = ANY('CA', 'CO', 'AR');
 
-- 7-3-3. ALL 연산자 - 괄호 안의 조건을 모두 만족하는 경우
-- (1) EMPLOYEES테이블에서 job_id가 'SA_MAN'인 사원보다
-- 급여를 많이 받는 사원의 사원명, job_id,salary 조회
SELECT emp_name, job_id, salary
  FROM employees
 WHERE salary > ALL(SELECT salary FROM employees WHERE job_id='ST_MAN')
   --AND job_id <> 'SA_MAN';