SELECT * FROM PERSON
SELECT * FROM DEPARTMENT
SELECT * FROM POSITION
--  Write an SQL query that retrieves all employees' first name, last name, and salary information.

SELECT [NAME_],[SURNAME],[SALARY] FROM PERSON

-- Write a query that lists only female employees (GENDER = 'K') along with their first name, last name, and date of birth.

SELECT [NAME_],[SURNAME],[BIRTHDATE] FROM PERSON WHERE GENDER = 'K'

-- List the names and hiring dates of employees who joined after 2017.

SELECT [NAME_],[INDATE] FROM PERSON WHERE YEAR(INDATE) > 2017

--  Add a new employee (Example: Ali Veli, ID Number: 12345678901, Male, born on 1985-12-05, hired on 2022-01-15, Department: 3, Position: 40, Salary: 6000).

INSERT INTO PERSON (
    [CODE], [TCNUMBER], [NAME_], [SURNAME], [GENDER], [BIRTHDATE], [INDATE], [DEPARTMENTID], [POSITIONID], [SALARY]) 
    VALUES ('EMP001', '12345678901', 'Ali', 'Veli', 'E', '1985-12-05', '2022-01-15', 3, 40, 6000)


SELECT * FROM PERSON WHERE [NAME_]= 'Ali'AND [SURNAME] = 'Veli'

-- Update Ferhat Cinar’s salary to 6000.

UPDATE PERSON SET SALARY = 6000 WHERE [NAME_] = 'Ferhat' AND [SURNAME] = 'CINAR'


SELECT * FROM PERSON WHERE [NAME_] = 'Ferhat' AND [SURNAME] = 'CINAR'

-- Delete Deniz Eravcı from the database.

DELETE FROM PERSON WHERE [NAME_] = 'Deniz' AND [SURNAME] = 'Eravcı'
SELECT * FROM PERSON WHERE [NAME_] = 'Deniz' AND [SURNAME] = 'Eravcı'

-- List employees who were born before 1960.

SELECT * FROM PERSON WHERE BIRTHDATE < '1960-01-01'

-- List employees who were born before 1960 and have a salary higher than 5000.

SELECT * FROM PERSON WHERE YEAR(BIRTHDATE) < 1960 AND SALARY > 5000

--  List employees whose Department ID is 4 or whose salary is greater than 5500.

SELECT * FROM PERSON WHERE DEPARTMENTID = 4 OR SALARY > 5500

-- -- Increase the salaries of employees whose exit date (OUTDATE) is NULL by 10%.

UPDATE PERSON SET SALARY = SALARY * 1.10 WHERE OUTDATE IS NULL

-- Delete employees who were hired before 2015 and have a salary lower than 5000.

DELETE FROM PERSON WHERE YEAR(INDATE) < 2015 AND SALARY < 5000

SELECT * FROM PERSON WHERE YEAR(INDATE) < 2015 AND SALARY < 5000

-- List the number of different departments in the dataset.

SELECT COUNT(DISTINCT DEPARTMENTID) AS Department_Count FROM PERSON

-- Sort employees by salary from highest to lowest.

SELECT * FROM PERSON ORDER BY SALARY DESC

-- List the top 5 highest-paid employees.

SELECT TOP 5 * FROM PERSON ORDER BY SALARY DESC