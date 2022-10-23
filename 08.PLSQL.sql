-- PLSQL
-- 1. �͸��� - ���������� ������ ���� / DECLARE, BEGIN, END�� ����
DECLARE
  num NUMBER;
BEGIN
  num := 10;
  
  DBMS_OUTPUT.PUT_LINE(num);
END;
----------------------------------------------------------------------------------------
-- �������� 1 
-- �����ȣ�� 110�� ����� �μ�Ƽ�� ���, �μ�Ƽ������ 0.12(�޿�*�μ�Ƽ����)
-- ��³��� : ����� - �μ�Ƽ�� �ݾ�
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
-- �������� 2
-- employees���̺��� �����ȣ�� 201�� ����� �̸��� �̸����ּҸ� ����ϴ� �͸��� �ۼ�
-- ��³��� : �̸� : �̸����ּ�
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
-- 2. ���ǹ�
-- 2-1 IF
-- (2-1-1) ū ���� ����ϴ� IF��
DECLARE
  vn_num1 NUMBER := 10;
  vn_num2 NUMBER := 20;
BEGIN
  IF vn_num1 > vn_num2 THEN
    DBMS_OUTPUT.put_line('ū �� = ' || vn_num1);
  ELSE
    DBMS_OUTPUT.put_line('ū �� = ' || vn_num2);
  END IF;
END;
----------------------------------------------------------------------------------------
-- (2-1-2) DBMS_RANDOM��Ű���� �̿��� 10~120������ ���ڸ� ������ �μ���ȣ�� ����
-- �� �μ��� ù��° ����� �޿��� ��ȸ�� (rownum = 1)
-- �޿��� 3000���� ������ '����'
-- 3000~6000���̸� '�߰�'
-- 6001~10000���̸� '����'
-- 10001�̻��̸� '�ֻ���'
-- ������� : "�����, �޿��ݾ�, �޿�����:�߰�"
DECLARE
  id NUMBER;
  name VARCHAR2(20);
  sal NUMBER;
BEGIN
  id := ROUND(DBMS_RANDOM.VALUE(10, 120), -1);
  DBMS_OUTPUT.put_line('�μ���ȣ = ' || id);
  
  SELECT emp_name, salary
    INTO name, sal
    FROM employees
   WHERE rownum = 1
     AND department_id = id;
  DBMS_OUTPUT.put_line('�޿� = ' || sal);
  
  IF sal > 10001 THEN
    DBMS_OUTPUT.put_line('�ֻ�');
  ELSIF sal BETWEEN 6001 AND 10000 THEN
    DBMS_OUTPUT.put_line('����');
  ELSIF sal BETWEEN 3000 AND 6000 THEN
    DBMS_OUTPUT.put_line('����');
  ELSE
    DBMS_OUTPUT.put_line('����');
  END IF;
  
END;
----------------------------------------------------------------------------------------
-- 2-2. CASE ���ǹ�
-- (2-2-1) DBMS_RANDOM��Ű���� �̿��� 10~120������ ���ڸ� ������ �μ���ȣ�� ����
-- �� �μ��� ù��° ����� �޿��� ��ȸ�� (rownum = 1)
-- �޿��� 3000���� ������ '����'
-- 3000~6000���̸� '�߰�'
-- 6001~10000���̸� '����'
-- 10001�̻��̸� '�ֻ���'
-- ������� : "�����, �޿��ݾ�, �޿�����:�߰�"
DECLARE
  id NUMBER;
  name VARCHAR2(20);
  sal NUMBER;
BEGIN
  id := ROUND(DBMS_RANDOM.VALUE(10, 120), -1);
  DBMS_OUTPUT.put_line('�μ���ȣ = ' || id);
  
  SELECT emp_name, salary
    INTO name, sal
    FROM employees
   WHERE rownum = 1
     AND department_id = id;
  DBMS_OUTPUT.put_line('�޿� = ' || sal);
  
  CASE 
    WHEN sal > 10001 THEN
      DBMS_OUTPUT.put_line('�ֻ�');
    WHEN sal BETWEEN 6001 AND 10000 THEN
      DBMS_OUTPUT.put_line('����');
    WHEN sal BETWEEN 3000 AND 6000 THEN
      DBMS_OUTPUT.put_line('����');
    ELSE 
      DBMS_OUTPUT.put_line('����');
  END CASE;
END;  
----------------------------------------------------------------------------------------
-- 3. �ݺ���
-- 3-1. WHILE
-- (3-1-1) ������
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
-- (3-2-1) ������
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
-- (1) ������ 3��
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
-- (1) ������ 3�� �� i�� ������ ���ڰ� ���� �� 4������ �Ѿ��
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