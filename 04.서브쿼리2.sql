-- 서브쿼리2
-- 1. 1개의 컬럼 값을 반환하는 서브쿼리문
-- (1-1) orders_ex테이블에서 주문일자가 2012-10-10일 평균 주문금액보다 큰 주문금액 조회
SELECT *
  FROM orders_ex
 WHERE purch_amt > (SELECT AVG(purch_amt)
                      FROM orders_ex
                     WHERE ord_date = '2012-10-10');
---------------------------------------------------------------------------------
-- (1-2) departments테이블에서 parent_id가 없는 부서에 속하는 사원수를 조회
SELECT count(*)
  FROM employees
 WHERE department_id = ( SELECT department_id
                           FROM departments
                          WHERE parent_id = NULL);
---------------------------------------------------------------------------------
-- (1-3) 매니저가 존재하는 부서에 속하는 사원의 수 조회
SELECT count(*)
  FROM employees
 WHERE department_id IN ( SELECT department_id
                            FROM departments
                           WHERE manager_id IS NOT NULL);
---------------------------------------------------------------------------------
-- (1-4) salesman, order_ex테이블을 이용해 paris를 담당하는 영업사원들에 대한 모든 주문정보를 조회
SELECT *
  FROM orders_ex
 WHERE salesman_id = ANY ( SELECT salesman_id
                         FROM salesman
                        WHERE city = 'Paris');
---------------------------------------------------------------------------------
-- (1-5) salesman, orders_ex테이블을 이용해 paul adam이 판매한 모든 주문정보를 조회
SELECT *
  FROM orders_ex
 WHERE salesman_id = ANY (SELECT salesman_id
                            FROM salesman
                           WHERE name = 'Paul Adam');
---------------------------------------------------------------------------------
-- 2. 동시에 2개 이상의 컬럼 값을 반환하는 서브쿼리
-- (2-1) employees테이블에서 job_history테이블에 존재하는 사원번호, 직책번호 값을 가지는 사원의 정보를 조회
SELECT *
  FROM employees
 WHERE (employee_id, job_id) = ANY ( SELECT employee_id, job_id
                                     FROM job_history);
---------------------------------------------------------------------------------
-- (2-2) 부서별로 최대급여를 받는 사원의 사원번호, 사원명, 급여 조회 (부서번호, 부서별 최대급여 조회)
SELECT *
  FROM employees
 WHERE (NVL(department_id, 0), salary) = ANY ( SELECT NVL(department_id, 0), MAX(salary)
                                                 FROM employees
                                             GROUP BY department_id);
---------------------------------------------------------------------------------
-- 3 SELECT가 아닌 다른 문에서의 사용
-- (3-1) 모든 사원의 급여를 전 사원의 평균급여로 수정
UPDATE salary
   SET salary = ( SELECT AVG(salary) FROM employees);
---------------------------------------------------------------------------------
-- 4. 연관성 있는 서브쿼리
-- (4-1) job_history에 존재하는 모든 레코드에 대해 부서번호를 추출해
-- department테이블에서 부서번호, 부서명 조회
SELECT department_id, department_name
  FROM departments d
 WHERE EXISTS (SELECT department_id
                 FROM job_history j
                WHERE j.department_id = d.department_id);
---------------------------------------------------------------------------------
-- (4-2) salesman, customer_ex테이블을 참조해 2명 이상의 고객을 가진 영업사원의 정보 조회
SELECT *
  FROM salesman s
 WHERE salesman_id, count(salesman_id) = ( SELECT salesman_id, count(salesman_id)
                                             FROM customer_ex c
                                         GROUP BY salesman_id);
---------------------------------------------------------------------------------
-- 5. SELECT에서의 서브쿼리
-- (5-1) job_history의 모든 행에 대해 사원번호, 사원명, 부서번호, 부서명 조회
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
-- (5-2) orders_ex테이블에서 전체 주문을 조회하고 각 주문의 고객명과 영업사원명을 함께 조회
SELECT ord_no, purch_amt, ord_date, ( SELECT cust_name
                                        FROM customer_ex c
                                       WHERE c.customer_id = o.customer_id) 고객명,
                                    ( SELECT name
                                        FROM salesman s
                                       WHERE s.salesman_id = o.salesman_id) 사원명
  FROM orders_ex o;
---------------------------------------------------------------------------------
-- (5-3) 평균급여보다 많이 받는 직원이 있는 부서의 부서번호와 부서명 조회
SELECT department_id, department_name
  FROM departments d
 WHERE EXISTS (SELECT department_id
                 FROM employees e
                WHERE e.department_id = d.department_id
                  AND salary > ( SELECT AVG(salary)
                                   FROM employees));
---------------------------------------------------------------------------------
-- 6. 연관성 있는 서브쿼리 사용
-- (6-1) parent_id가 90인 부서에 속하는 부서의 평균급여보다 많이 받는
-- 사원의 사원번호, 사원명, 부서번호, 부서명 조회
-- (1) parent_id가 90인 부서에 속하는 모든 사원들의 평균급여 조회
SELECT FLOOR(AVG(salary))
  FROM employees e, departments d
 WHERE e.department_id = d.department_id
   AND parent_id = 90;
---------------------------------------------------------------------------------
-- (2) 위의 SQL을 뷰로 생성   
CREATE OR REPLACE VIEW avg_view AS
SELECT FLOOR(AVG(salary)) avgsal
  FROM employees e, departments d
 WHERE e.department_id = d.department_id
   AND parent_id = 90;
---------------------------------------------------------------------------------
-- (3) 문제 SQL 작성
SELECT e.employee_id, e.emp_name, e.salary, d.department_id, d.department_name
  FROM employees e, departments d, avg_view v
 WHERE e.department_id = d.department_id
   AND e.salary > v.avgsal;
---------------------------------------------------------------------------------
-- (6-2) orders_ex, customer_ex 각 고객에 대하여
-- 고객자신의 평균 주문금액보다 큰 주문금액을 가진 모든 주문 조회
-- (1) 각 고객의 평균주문금액 조회
SELECT cust_name, FLOOR(AVG(purch_amt))
  FROM customer_ex c, orders_ex o
 WHERE c.customer_id = o.customer_id
GROUP BY cust_name;
---------------------------------------------------------------------------------
-- (2) orders_ex, 가상뷰를 조인해 평균금액보다 큰 주문금액 조회
SELECT o.customer_id, o.purch_amt 구매금액
  FROM orders_ex o, (SELECT customer_id, TRUNC(AVG(purch_amt)) avgpurch
                       FROM orders_ex
                   GROUP BY customer_id) tmp
WHERE o.customer_id = tmp.customer_id
  AND o.purch_amt > tmp.avgpurch
ORDER BY o.customer_id;
---------------------------------------------------------------------------------
-- (6-3) 점수가 NewYork에 거주하는 고객의 평균점수 이상인 고객의 점수와 수를 조회
-- 관련테이블 : customer_ex
-- (1) 뉴욕 고객의 평균점수 조회
SELECT AVG(grade)
  FROM customer_ex
 WHERE city = 'New York';
---------------------------------------------------------------------------------
-- (2) 위의 평균점수보다 큰 점수와 고객수 주회
SELECT grade, count(*)
  FROM customer_ex
 WHERE grade > ( SELECT AVG(grade)
                   FROM customer_ex
                  WHERE city = 'New York')
GROUP BY grade;
---------------------------------------------------------------------------------
-- (6-4) orders_ex테이블에서 수수료가 가장 큰 영업사원에 대해 모든 주문정보 조회
-- (1) 영업사원의 최대 수수료 조회
SELECT MAX(commision)
  FROM salesman;
---------------------------------------------------------------------------------
-- (1-1) 서브쿼리를 이용해 최대 수수료를 받는 영업사원 조회
SELECT *
  FROM salesman
 WHERE commision = ( SELECT MAX(commision)
                      FROM salesman);
---------------------------------------------------------------------------------                      
-- (2) orders_ex테이블에서 최대 수수료를 받는 영업사원들의 모든 주문정보 조회 
SELECT *
  FROM orders_ex
 WHERE salesman_id = ANY ( SELECT salesman_id
                             FROM salesman
                            WHERE commision = ( SELECT MAX(commision)
                             FROM salesman));