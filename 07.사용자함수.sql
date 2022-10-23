-- ����� ���� �Լ�
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
-- �������� 1
-- IF ELSIF ELSE���� �̿��� jobs���̺��� ����, ���� salary ��հ��� �̿��Ͽ� �Է¹��� salary��
-- ���� ����������� �ִ���� �̻����� ��ձ������� ����ϴ� ���ν��� ����
CREATE OR REPLACE PROCEDURE avgsal_check(sal IN NUMBER) AS
  max_sal_avg NUMBER;
  min_sal_avg NUMBER;
BEGIN
  SELECT AVG(max_salary), AVG(min_salary)
    INTO max_sal_avg, min_sal_avg
    FROM jobs;
   
  IF sal > max_sal_avg THEN
    DBMS_OUTPUT.PUT_LINE('��� �̻��Դϴ�.');
  ELSIF sal BETWEEN min_sal_avg AND max_sal_avg THEN
    DBMS_OUTPUT.PUT_LINE('����Դϴ�.');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('��� �����Դϴ�.');
  END IF;
END;

EXEC avgsal_check(5000);
---------------------------------------------------------------------------------------
-- WHILE���� �̿��� ������ ���ν��� ����
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