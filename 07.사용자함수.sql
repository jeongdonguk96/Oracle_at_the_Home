-- 사용자 정의 함수
CREATE OR REPLACE FUNCTION to_yyyymmdd(date DATE)
  RETURN VARCHAR2
IS
  char_date VARCHAR2(20);
BEGIN
  char_date := TO_CHAR(date, 'yyyy-mm-dd');
  RETURN char_date;
END;

SELECT to_yyyymmdd(sysdate) FROM dual;
---------------------------------------------------------------------------------------
-- 연습문제 1
-- IF ELSIF ELSE문을 이용해 jobs테이블의 최저, 최저 salary 평균값을 이용하여 입력받은 salary가
-- 최저 평균이하인지 최대평균 이상인지 평균구간인지 출력하는 프로시저 정의
CREATE OR REPLACE PROCEDURE avgsal_check(sal IN NUMBER) AS
  max_sal_avg NUMBER;
  min_sal_avg NUMBER;
BEGIN
  SELECT AVG(max_salary), AVG(min_salary)
    INTO max_sal_avg, min_sal_avg
    FROM jobs;
   
  IF sal > max_sal_avg THEN
    DBMS_OUTPUT.PUT_LINE('평균 이상입니다.');
  ELSIF sal BETWEEN min_sal_avg AND max_sal_avg THEN
    DBMS_OUTPUT.PUT_LINE('평균입니다.');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('평균 이하입니다.');
  END IF;
END;

EXEC avgsal_check(5000);
---------------------------------------------------------------------------------------
-- WHILE문을 이용해 구구단 프로시저 정의
CREATE OR REPLACE PROCEDURE gugudan AS
  i NUMBER;
  j NUMBER;
BEGIN
  i := 2;
  WHILE(i<=9) LOOP
    j := 1;
    WHILE(j<=9) LOOP
      DBMS_OUTPUT.PUT_LINE(i || ' * ' || j || ' = ' || i*j);
      j := j+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(' ');
    i := i+1;
  END LOOP;
END;

exec gugudan;