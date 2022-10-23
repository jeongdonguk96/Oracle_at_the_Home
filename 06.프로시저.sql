-- ���ν���
---------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE first_emp AS
  employee_name VARCHAR2(20);
BEGIN
  SELECT emp_name INTO employee_name
    FROM employees
   WHERE employee_id = 100;
   
   DBMS_OUTPUT.PUT_LINE('ù��° ������ �̸��� = ' || employee_name);
END; 

EXEC first_emp;
---------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE print_emp(emp_id IN employees.employee_id%TYPE) AS
  employee_name VARCHAR2(20);
BEGIN
  SELECT emp_name INTO employee_name
    FROM employees
   WHERE employee_id = emp_id;

  DBMS_OUTPUT.PUT_LINE('ù��° ������ �̸��� = ' || employee_name);

END;  

EXEC print_emp(106);
---------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE avg_sal(emp_sal OUT employees.salary%TYPE) AS

BEGIN
  SELECT FLOOR(AVG(salary)) INTO emp_sal
    FROM employees;
  
END;

DECLARE
  emp_sal employees.salary%TYPE;
BEGIN
  avg_sal(emp_sal);
  
  DBMS_OUTPUT.PUT_LINE('�������� ��� �޿��� = ' || emp_sal);
END;
---------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE if_sal(salary IN NUMBER) AS
  avg_sal NUMBER;
BEGIN
 SELECT AVG(salary) INTO avg_sal
   FROM employees;

  IF salary > avg_sal THEN
    DBMS_OUTPUT.PUT_LINE('��� �̻��Դϴ�.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('��� �����Դϴ�.');
  END IF;
END;

EXEC if_sal(7000);
---------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE case_hiredate(emp_email employees.email%TYPE) AS
  hire_year NCHAR(2);
  text_msg VARCHAR2(20);
BEGIN
  SELECT TO_CHAR(hire_date, 'YY') INTO hire_year
    FROM employees
   WHERE email = emp_email;
   
   CASE
     WHEN (hire_year = '01') THEN text_msg := '01�⵵ �Ի���';
     WHEN (hire_year = '02') THEN text_msg := '02�⵵ �Ի���';
     WHEN (hire_year = '03') THEN text_msg := '03�⵵ �Ի���';
     WHEN (hire_year = '04') THEN text_msg := '04�⵵ �Ի���';
     WHEN (hire_year = '05') THEN text_msg := '05�⵵ �Ի���';
     WHEN (hire_year = '06') THEN text_msg := '06�⵵ �Ի���';
     WHEN (hire_year = '07') THEN text_msg := '07�⵵ �Ի���';
     WHEN (hire_year = '08') THEN text_msg := '08�⵵ �Ի���';
     WHEN (hire_year = '09') THEN text_msg := '09�⵵ �Ի���';
     ELSE text_msg := '01~09�⵵ �̿ܿ� �Ի���';
  END CASE;
  
  DBMS_OUTPUT.PUT_LINE(text_msg);
END;

EXEC case_hiredate('SKING');
---------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE while_print AS
  str VARCHAR(100);
  i NUMBER;
BEGIN
  i := 1;
  WHILE(i<=10) LOOP
    str := '�ݺ�Ƚ�� = ' || i;
    DBMS_OUTPUT.PUT_LINE(str);
    i := i+1;
  END LOOP;

END;

EXEC while_print;
---------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE out_emp(emp_id IN employees.employee_id%TYPE,
                                    out_str OUT VARCHAR2) AS
  employee_name employees.emp_name%TYPE;
BEGIN
  SELECT emp_name INTO employee_name
    FROM employees
   WHERE employee_id = emp_id;
   
  out_str := '������ = ' || employee_name;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        out_str := '�ش� ���� ����';
END;

DECLARE
  out_str VARCHAR2(30);
BEGIN
  out_emp(300, out_str);
  DBMS_OUTPUT.PUT_LINE(out_str);
END;  

---------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE inout_emp(employee_name IN OUT VARCHAR2) AS

BEGIN
  SELECT emp_name INTO employee_name
    FROM employees
   WHERE emp_name = employee_name;
   
  employee_name := '������ = ' || employee_name;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        employee_name := '�ش� ���� ����';
END;

DECLARE
  employee_name VARCHAR2(30) := 'Steven King';
BEGIN
  inout_emp(employee_name);
  DBMS_OUTPUT.PUT_LINE(employee_name);
END;
---------------------------------------------------------------------------------------
-- Ŀ���� ����ϴ� ���ν���
CREATE OR REPLACE PROCEDURE cursor_salary AS
  sal NUMBER := 0;
  cnt NUMBER := 0;
  total NUMBER := 0;
  CURSOR emp_cursor 
  IS
  SELECT salary
    FROM employees;
BEGIN
  OPEN emp_cursor;
  LOOP 
    FETCH emp_cursor INTO sal;
    EXIT WHEN emp_cursor%NOTFOUND;
    total := total + sal;
    cnt := cnt + 1;
  END LOOP;
  CLOSE emp_cursor;
  
  DBMS_OUTPUT.PUT_LINE('��� salary = ' || (total/cnt));
END;

EXEC cursor_salary;