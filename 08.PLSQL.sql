-- PLSQL
-- 1. 익명블록 - 변수선언이 가능한 문장 / DECLARE, BEGIN, END로 구성
DECLARE
  num NUMBER;
BEGIN
  num := 10;
  
  DBMS_OUTPUT.PUT_LINE(num);
END;
----------------------------------------------------------------------------------------
-- 연습문제 1 
-- 사원번호가 110인 사원의 인센티브 계산, 인센티브율은 0.12(급여*인센티브율)
-- 출력내용 : 사원명 - 인센티브 금액
DECLARE
  emp_name VARCHAR2(20);
  insen NUMBER;
BEGIN
  SELECT emp_name, salary+(salary*0.12) insen
    INTO emp_name, insen
    FROM employees
   WHERE employee_id = 100;
   
   DBMS_OUTPUT.put_line(emp_name || ' - ' || insen);
END;
----------------------------------------------------------------------------------------
-- 연습문제 2
-- employees테이블에서 사원번호가 201인 사원의 이름과 이메일주소를 출력하는 익명블록 작성
-- 출력내용 : 이름 : 이메일주소
DECLARE 
  name VARCHAR2(20);
  mail VARCHAR2(10);
BEGIN
  SELECT emp_name, email
    INTO name, mail
    FROM employees
   WHERE employee_id = 201;
   
  DBMS_OUTPUT.put_line(name || ' : ' || mail);
END;
----------------------------------------------------------------------------------------
-- 2. 조건문
-- 2-1 IF
-- (2-1-1) 큰 수를 출력하는 IF문
DECLARE
  vn_num1 NUMBER := 10;
  vn_num2 NUMBER := 20;
BEGIN
  IF vn_num1 > vn_num2 THEN
    DBMS_OUTPUT.put_line('큰 수 = ' || vn_num1);
  ELSE
    DBMS_OUTPUT.put_line('큰 수 = ' || vn_num2);
  END IF;
END;
----------------------------------------------------------------------------------------
-- (2-1-2) DBMS_RANDOM패키지를 이용해 10~120사이의 숫자를 생성해 부서번호로 생성
-- 그 부서의 첫번째 사원의 급여를 조회해 (rownum = 1)
-- 급여가 3000보다 적으면 '낮음'
-- 3000~6000사이면 '중간'
-- 6001~10000사이면 '높음'
-- 10001이상이면 '최상위'
-- 출력형식 : "사원명, 급여금액, 급여수준:중간"
DECLARE
  id NUMBER;
  name VARCHAR2(20);
  sal NUMBER;
BEGIN
  id := ROUND(DBMS_RANDOM.VALUE(10, 120), -1);
  DBMS_OUTPUT.put_line('부서번호 = ' || id);
  
  SELECT emp_name, salary
    INTO name, sal
    FROM employees
   WHERE rownum = 1
     AND department_id = id;
  DBMS_OUTPUT.put_line('급여 = ' || sal);
  
  IF sal > 10001 THEN
    DBMS_OUTPUT.put_line('최상');
  ELSIF sal BETWEEN 6001 AND 10000 THEN
    DBMS_OUTPUT.put_line('상위');
  ELSIF sal BETWEEN 3000 AND 6000 THEN
    DBMS_OUTPUT.put_line('중위');
  ELSE
    DBMS_OUTPUT.put_line('하위');
  END IF;
  
END;
----------------------------------------------------------------------------------------
-- 2-2. CASE 조건문
-- (2-2-1) DBMS_RANDOM패키지를 이용해 10~120사이의 숫자를 생성해 부서번호로 생성
-- 그 부서의 첫번째 사원의 급여를 조회해 (rownum = 1)
-- 급여가 3000보다 적으면 '낮음'
-- 3000~6000사이면 '중간'
-- 6001~10000사이면 '높음'
-- 10001이상이면 '최상위'
-- 출력형식 : "사원명, 급여금액, 급여수준:중간"
DECLARE
  id NUMBER;
  name VARCHAR2(20);
  sal NUMBER;
BEGIN
  id := ROUND(DBMS_RANDOM.VALUE(10, 120), -1);
  DBMS_OUTPUT.put_line('부서번호 = ' || id);
  
  SELECT emp_name, salary
    INTO name, sal
    FROM employees
   WHERE rownum = 1
     AND department_id = id;
  DBMS_OUTPUT.put_line('급여 = ' || sal);
  
  CASE 
    WHEN sal > 10001 THEN
      DBMS_OUTPUT.put_line('최상');
    WHEN sal BETWEEN 6001 AND 10000 THEN
      DBMS_OUTPUT.put_line('상위');
    WHEN sal BETWEEN 3000 AND 6000 THEN
      DBMS_OUTPUT.put_line('중위');
    ELSE 
      DBMS_OUTPUT.put_line('하위');
  END CASE;
END;  
----------------------------------------------------------------------------------------
-- 3. 반복문
-- 3-1. WHILE
-- (3-1-1) 구구단
DECLARE
  i NUMBER;
  j NUMBER;  
BEGIN
  i := 2;
  WHILE(i<10) LOOP
    j := 1;
    WHILE(j<10) LOOP
      DBMS_OUTPUT.put_line(i || ' * ' || j || ' = ' || i*j);
      j := j+1;
    END LOOP;
    DBMS_OUTPUT.put_line('');
    i := i+1;
  END LOOP;
  
END;
----------------------------------------------------------------------------------------
-- 3-2. FOR
-- (3-2-1) 구구단
DECLARE
  i NUMBER := 0;
  j NUMBER := 0;  
BEGIN
  FOR i IN 2..9
  LOOP
    FOR j IN 1..9
    LOOP
      DBMS_OUTPUT.put_line(i || ' * ' || j || ' = ' || i*j);
    END LOOP;
    DBMS_OUTPUT.put_line('');
  END LOOP;
END;
----------------------------------------------------------------------------------------
-- 4. COUNTINUE
-- (1) 구구단 3단
DECLARE
  vn_base_num NUMBER := 3;
BEGIN
  FOR i IN 1..9
  LOOP
    CONTINUE WHEN i = 5;
    DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= '
                          || vn_base_num * i);
  END LOOP;
END;
----------------------------------------------------------------------------------------
-- 5. GOTO
-- (1) 구구단 3단 중 i가 지정한 숫자가 됐을 때 4단으로 넘어가기
DECLARE
  vn_base_num NUMBER := 3;
BEGIN
  <<third>>
  FOR i IN 1..9
  LOOP
    DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
    IF i=3 THEN GOTO fourth;
    END IF;
  END LOOP;
  <<fourth>>
    vn_base_num := 4;
  FOR i IN 1..9
  LOOP
    DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
  END LOOP;
END;

----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------