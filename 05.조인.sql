-- 조인
-- 1. 이너조인
-- 1-1. 동등조인 - 기본키와 외래키를 매개로 조인
-- (1) 전체 직원의 사원번호, 사원명, 부서번호, 부서명을 조회
SELECT employee_id, emp_name, d.department_id, department_name
  FROM employees e, departments d
 WHERE e.department_id = d.department_id;
----------------------------------------------------------------------------------------
-- (2) 같은 도시에 속하는 고객과 영업사원의 고객명, 도시명, 사원번호, 사원명 조회
SELECT c.cust_name, c.city, s.salesman_id, s.name
  FROM customer_ex c, salesman s
 WHERE c.city = s.city;
----------------------------------------------------------------------------------------
-- (3) 주문금액이 500~2000사이인 주문에 대해서 주문번호, 주문금액, 고객번호, 주문도시 조회
SELECT o.ord_no, o.purch_amt, c.customer_id, c.city
  FROM orders_ex o, customer_ex c
 WHERE o.purch_amt BETWEEN 500 AND 2000
   AND o.customer_id = c.customer_id;
----------------------------------------------------------------------------------------
-- 1-2. 세미조인 - IN과 EXISTS를 사용
-- (1) EXISTS를 사용해 급여가 3000이상인 사원의 부서번호, 부서명 조회
SELECT d.department_id, department_name
  FROM departments d
 WHERE EXISTS (SELECT *
                 FROM employees e
                WHERE salary >= 3000
                  AND e.department_id = d.department_id);
----------------------------------------------------------------------------------------
-- (2) IN을 사용해 급여가 3000이상인 사원의 부서번호, 부서명 조회
SELECT d.department_id, department_name
  FROM departments d
 WHERE d.department_id IN ( SELECT department_id
                           FROM employees
                          WHERE salary >= 3000);
----------------------------------------------------------------------------------------
-- 1-3. 셀프조인 - 동일한 테이블을 사용해 조인(한 테이블의 컬럼끼리 조건)
----------------------------------------------------------------------------------------
-- 2. OUTER JOIN
-- (2-1)cust_ex, buy테이블을 이용해 고객번호, 고객명, 제품번호, 금액 조회
SELECT c.custid, c.name, b.num, b.price
  FROM cust_ex c, buy b
 WHERE c.custid = b.custid(+);
----------------------------------------------------------------------------------------
-- (2-2) employees테이블에서 모든 사원에 대한 사원번호, 사원명, 직책번호, 시작일, 종료일 조회
SELECT e.employee_id, e.emp_name, e.job_id, j.start_date, j.end_date
  FROM employees e, job_history j
 WHERE e.employee_id = j.employee_id(+);
----------------------------------------------------------------------------------------
-- (2-3)
SELECT *
  FROM jobs j, job_history jj
 WHERE j.job_id = jj.job_id(+);
----------------------------------------------------------------------------------------
-- 3. 안시조인
-- (3-1) -- 2003년 1월 1일 이후에 입사한 사원의 사번, 이름, 부서번호, 부서명 조회
-- (1) 기존 오라클 문법 사용
SELECT employee_id, emp_name, e.department_id, department_name
  FROM employees e, departments d
 WHERE hire_date > '2003-01-01'
   AND e.department_id = d.department_id;

-- (2) ANSI JOIN문법 사용
SELECT employee_id, emp_name, e.department_id, department_name
  FROM employees e
 INNER JOIN departments d
    ON e.department_id = d.department_id
 WHERE hire_date > '2003-01-01';
----------------------------------------------------------------------------------------
-- (3-2) 모든 직원의 발령내역 조회
SELECT e.employee_id, e.emp_name, j.job_id, j.start_date, j.end_date
  FROM employees e
LEFT OUTER JOIN job_history j
    ON e.employee_id = j.employee_id;
----------------------------------------------------------------------------------------
-- (3-3) 모든 영업사원의 고객정보를 조회하여 사원명순으로 조회
SELECT s.name, s.salesman_id, c.customer_id, c.cust_name, c.city, c.grade
  FROM salesman s
LEFT OUTER JOIN customer_ex c
    ON s.salesman_id = c.salesman_id
ORDER BY s.name;