SELECT * FROM EMPLOYEES;
SELECT * FROM  JOB_HISTORY;
SELECT * FROM  JOBS;
SELECT * FROM  DEPARTMENTS;
SELECT * FROM LOCATIONS;


-- SUB-QUERIES / NESTED QUERIES
-- Using sub-query in the where clause

SELECT EMP_ID, F_NAME, L_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < (select AVG(SALARY) from employees);

-- Executing a Column Expression 

SELECT EMP_ID, SALARY, (SELECT MAX(SALARY) FROM EMPLOYEES) as MAX_SALARY 
FROM EMPLOYEES;

-- Executing a TABLE EXPRESSION

select * from ( select EMP_ID, F_NAME, L_NAME, DEP_ID from employees);

--Accessing Multiple Tables with Sub-Queries

select * from employees
where DEP_ID IN (select dept_id_dep from departments WHERE loc_id = 'l0002');

select * from employees 
where JOB_ID IN (select JOB_IDENT from jobs);

select JOB_TITLE, MIN_SALARY, MAX_SALARY, JOB_IDENT from JOBS 
where JOB_IDENT IN (select JOB_ID from EMPLOYEES where SALARY > 70000);

select JOB_TITLE, MIN_SALARY, MAX_SALARY, JOB_IDENT from JOBS 
where JOB_IDENT IN (select JOB_ID from EMPLOYEES where YEAR(B_DATE) > 1976);

select JOB_TITLE, MIN_SALARY, MAX_SALARY, JOB_IDENT from JOBS 
where JOB_IDENT IN (select JOB_ID from EMPLOYEES where YEAR(B_DATE) > 1976 AND SEX = 'F');

--Accessing Multiple Tables with Implicit Joins
select * from employees, jobs;

select * from employees, jobs where employees.JOB_ID = jobs.JOB_IDENT;

select * from employees E, jobs J where E.JOB_ID = J.JOB_IDENT;

select EMP_ID, F_NAME, L_NAME, JOB_TITLE from employees E, jobs J where E.JOB_ID = J.JOB_IDENT;

select E.EMP_ID,E.F_NAME,E.L_NAME, J.JOB_TITLE from employees E, jobs J where E.JOB_ID = J.JOB_IDENT;



SELECT * FROM EMPLOYEES;
SELECT * FROM JOB_HISTORY;
SELECT * FROM JOBS;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

-- INNER JOIN
SELECT E.F_NAME, E.L_NAME, JH.START_DATE
FROM EMPLOYEES AS E
INNER JOIN JOB_HISTORY AS JH
ON E.EMP_ID = JH.EMPL_ID
WHERE E.DEP_ID = 5;

Select E.F_NAME,E.L_NAME, JH.START_DATE, J.JOB_TITLE 
From EMPLOYEES as E 
INNER JOIN JOB_HISTORY as JH 
On E.EMP_ID = JH.EMPL_ID 
INNER JOIN JOBS as J 
On E.JOB_ID = J.JOB_IDENT
where E.DEP_ID ='5';

-- OUTER JOINS
SELECT E.EMP_ID, E.L_NAME, E.DEP_ID, D.DEP_NAME
FROM EMPLOYEES AS E
LEFT OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID = D.DEPT_ID_DEP;

SELECT E.EMP_ID, E.L_NAME, E.DEP_ID, D.DEP_NAME
FROM EMPLOYEES AS E
LEFT OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID = D.DEPT_ID_DEP
AND YEAR(E.B_DATE) < 1980;

-- FULL JOINS
SELECT E.F_NAME, E.L_NAME, D.DEP_NAME
FROM EMPLOYEES AS E
FULL OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID = D.DEPT_ID_DEP;

SELECT E.F_NAME, E.L_NAME, E.SEX, D.DEP_NAME
FROM EMPLOYEES AS E
FULL OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID = D.DEPT_ID_DEP
AND E.SEX = 'M';

--CROSS JOIN 

--SELECT column_name(s)
--FROM table1
--CROSS JOIN table2;

--SELF JOIN 

--SELECT column_name(s)
--FROM table1 R1, table1 R2
--WHERE condition;


SELECT * FROM CHICAGO_PUBLIC_SCHOOLS;
SELECT * FROM CHICAGO_CRIME_DATA;
SELECT * FROM CENSUS_DATA;

--List the case number, type of crime and community area for all crimes in community area number 18.

SELECT CCD.CASE_NUMBER, CCD.PRIMARY_TYPE, CD.COMMUNITY_AREA_NAME
FROM CHICAGO_CRIME_DATA AS CCD
INNER JOIN CENSUS_DATA AS CD
ON CCD.COMMUNITY_AREA_NUMBER = CD.COMMUNITY_AREA_NUMBER
WHERE CCD.COMMUNITY_AREA_NUMBER = 18;

--List all crimes that took place at a school. Include case number, crime type and community name.

SELECT CCD.CASE_NUMBER, CCD.PRIMARY_TYPE, CCD.LOCATION_DESCRIPTION, CD.COMMUNITY_AREA_NAME
FROM CHICAGO_CRIME_DATA AS CCD
LEFT OUTER JOIN CENSUS_DATA AS CD
ON CCD.COMMUNITY_AREA_NUMBER = CD.COMMUNITY_AREA_NUMBER
WHERE CCD.LOCATION_DESCRIPTION LIKE '%SCHOOL%';

--For the communities of Oakland, Armour Square, Edgewater and CHICAGO list the associated community_area_numbers and the case_numbers.

SELECT CD.COMMUNITY_AREA_NUMBER, CD.COMMUNITY_AREA_NAME, CCD.CASE_NUMBER
FROM CENSUS_DATA AS CD
FULL OUTER JOIN CHICAGO_CRIME_DATA AS CCD
ON CD.COMMUNITY_AREA_NUMBER = CCD.COMMUNITY_AREA_NUMBER
WHERE CD.COMMUNITY_AREA_NAME IN ('Oakland', 'Armour Square', 'Edgewater', 'CHICAGO');



