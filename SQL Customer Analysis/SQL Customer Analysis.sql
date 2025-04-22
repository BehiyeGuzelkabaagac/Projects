--Create a database named Customers and add the given Excel file as a table into it.
--1.Write a query to retrieve the customers whose names start with the letter 'A'.

SELECT * FROM CUSTOMERS WHERE NAMESURNAME LIKE 'A%'

--2.Retrieve customers who were born between the years 1990 and 1995 (including both years).

SELECT * FROM CUSTOMERS WHERE YEAR(BIRTHDATE) BETWEEN 1990 AND 1995;

--3.Write a query using JOIN to get customers living in Istanbul.

SELECT *
FROM CUSTOMERS
JOIN CITIES ON CUSTOMERS.[CITYID] = CITIES.[ID]
WHERE CITIES.[CITY] = 'İstanbul';

--4.Write a query using a subquery to get customers living in Istanbul.

SELECT *
FROM CUSTOMERS
WHERE CITYID = (
    SELECT ID
    FROM CITIES
    WHERE CITY = 'İstanbul'
);

--5.Write a query to get the number of customers in each city.

SELECT CITIES.CITY, COUNT(*) AS CustomerCount
FROM CUSTOMERS
JOIN CITIES ON CUSTOMERS.CITYID = CITIES.ID
GROUP BY CITIES.CITY;

--6.Retrieve cities with more than 10 customers, along with the customer count, sorted in descending order by the number of customers. 

SELECT CITIES.CITY, COUNT(*) AS CustomerCount
FROM CUSTOMERS
JOIN CITIES ON CUSTOMERS.CITYID = CITIES.ID
GROUP BY CITIES.CITY
HAVING COUNT(*) > 10
ORDER BY CustomerCount DESC;

--7.Write a query to get the number of male and female customers in each city. 

SELECT 
    CITIES.CITY,
    SUM(CASE WHEN CUSTOMERS.GENDER = 'E' THEN 1 ELSE 0 END) AS MaleCount,
    SUM(CASE WHEN CUSTOMERS.GENDER = 'K' THEN 1 ELSE 0 END) AS FemaleCount
FROM CUSTOMERS
JOIN CITIES ON CUSTOMERS.CITYID = CITIES.ID
GROUP BY CITIES.CITY;

--8.Add a new column called AGEGROUP to the Customers table for age grouping.

ALTER TABLE CUSTOMERS
ADD AGEGROUP VARCHAR(50);

--9.Update the AGEGROUP column in the Customers table with the following ranges: 20-35, 36-45, 46-55, 55-65, and over 65

UPDATE CUSTOMERS
SET AGEGROUP = 
    CASE 
        WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 20 AND 35 THEN '20-35'
        WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 36 AND 45 THEN '36-45'
        WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 46 AND 55 THEN '46-55'
        WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 56 AND 65 THEN '56-65'
        WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) > 65 THEN '65+'
        ELSE 'Unknown'
    END;


--10.List customers who live in Istanbul but not in the district of ‘Kadıköy’

SELECT *
FROM CUSTOMERS
JOIN CITIES ON CUSTOMERS.CITYID = CITIES.ID
JOIN DISTRICT ON CUSTOMERS.DISTRICTID = DISTRICT.ID
WHERE CITIES.CITY = 'İstanbul'
  AND DISTRICT.DISTRICT <> 'Kadıköy';

--11.We want to retrieve the operator code (e.g., 532, 505) next to the phone numbers TELNR1 and TELNR2. 
--Write the SQL query for this. 

SELECT 
    NAMESURNAME,
    TELNR1,
    TELNR2,
    SUBSTRING(TELNR1, 1, 3) AS Operator1,
    SUBSTRING(TELNR2, 1, 3) AS Operator2
FROM CUSTOMERS;

--12.We want to find the mobile operator based on the phone number prefix: those starting with “50” or “55” belong to operator “X”, those with “54” to “Y”, and “53” to “Z”. 
--Write a query to get the number of customers for each operator. 
SELECT 
    CASE 
        WHEN SUBSTRING(TELNR1, 2, 2) IN ('50', '55') THEN 'X'
        WHEN SUBSTRING(TELNR1, 2, 2) = '54' THEN 'Y'
        WHEN SUBSTRING(TELNR1, 2, 2) = '53' THEN 'Z'
        ELSE 'Unknown'
    END AS Operator,
    COUNT(*) AS CustomerCount
FROM CUSTOMERS
WHERE TELNR1 IS NOT NULL
GROUP BY 
    CASE 
        WHEN SUBSTRING(TELNR1, 2, 2) IN ('50', '55') THEN 'X'
        WHEN SUBSTRING(TELNR1, 2, 2) = '54' THEN 'Y'
        WHEN SUBSTRING(TELNR1, 2, 2) = '53' THEN 'Z'
        ELSE 'Unknown'
    END;


--13.Write a query to retrieve the district with the highest number of customers in each city, sorted in descending order of customer count. 
WITH CustomerCounts AS (
    SELECT 
        CITIES.CITY,
        DISTRICT.DISTRICT,
        COUNT(*) AS CustomerCount
    FROM CUSTOMERS
    JOIN CITIES ON CUSTOMERS.CITYID = CITIES.ID
    JOIN DISTRICT ON CUSTOMERS.DISTRICTID = DISTRICT.ID
    GROUP BY CITIES.CITY, DISTRICT.DISTRICT
),
RankedDistricts AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CITY ORDER BY CustomerCount DESC) AS rn
    FROM CustomerCounts
)
SELECT CITY, DISTRICT, CustomerCount
FROM RankedDistricts
WHERE rn = 1
ORDER BY CustomerCount DESC;

--14.Write a query to return the day of the week (Monday, Tuesday, etc.) for each customer's date of birth. 

SELECT 
    NAMESURNAME,
    BIRTHDATE,
    DATENAME(WEEKDAY, BIRTHDATE) AS DayOfWeek
FROM CUSTOMERS;
