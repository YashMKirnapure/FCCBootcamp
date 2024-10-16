--SELECT * FROM EmployeeDemographics
--WHERE FirstName LIKE 'R%' OR 
--LastName LIKE '%D%';

--SELECT * FROM EmployeeDemographics 
--WHERE FirstName IN ('Light','Calvin','Sergio','Randy') 
--OR Gender = 'Female';

/* GROUP BY , ORDER BY */
--SELECT DISTINCT(Gender) FROM EmployeeDemographics;

--SELECT COUNT(Gender) FROM EmployeeDemographics;

/*SELECT Gender , Age , COUNT(GENDER) FROM EmployeeDemographics 
GROUP BY GENDER,Age ORDER BY AGE DESC;*/

/*SELECT * FROM EmployeeDemographics
ORDER BY Age DESC , Gender ASC;*/

/*SELECT * FROM EmployeeDemographics
ORDER BY 4 ASC , 5 DESC;*/

/*SELECT * FROM EmployeeDemographics RIGHT JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;*/

/*SELECT EmployeeDemographics.EmployeeID,FirstName,LastName 
FROM EmployeeDemographics RIGHT JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;*/

/*SELECT EmployeeSalary.EmployeeID,FirstName,LastName 
FROM EmployeeDemographics RIGHT JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;*/

/*SELECT EmployeeDemographics.EmployeeID,FirstName,LastName,Salary 
FROM EmployeeDemographics INNER JOIN EmployeeSalary 
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID 
WHERE FirstName <> 'Calvin'
ORDER BY Salary DESC;*/

/*SELECT JobTitle , Salary 
FROM EmployeeDemographics ED INNER JOIN EmployeeSalary ES 
ON ED.EmployeeID = ES.EmployeeID
WHERE JobTitle = 'Salesman';*/

/*SELECT JobTitle , AVG(Salary) 
FROM EmployeeDemographics ED INNER JOIN EmployeeSalary ES 
ON ED.EmployeeID = ES.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle;*/

/*UPDATE EmployeeSalary SET EmployeeID = 1009 
WHERE JobTitle = 'Accountant' AND Salary = 42000;*/

--SELECT * FROM EmployeeSalary;

/*SELECT EmployeeID FROM EmployeeDemographics
UNION 
SELECT EmployeeID FROM EmployeeSalary;*/

/*SELECT EmployeeID FROM EmployeeDemographics
UNION ALL
SELECT EmployeeID FROM EmployeeSalary;*/

/*SELECT EmployeeID,FirstName,Age
FROM EmployeeDemographics 
UNION
SELECT EmployeeID,JobTitle,Salary
FROM EmployeeSalary
ORDER BY EmployeeID;*/

/*SELECT FirstName , LastName , Age,
CASE
	WHEN Age > 30 THEN 'Old'
	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
	ELSE 'Teen'
END
FROM EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age;*/


/*SELECT FirstName,LastName,JobTitle,Salary,
CASE
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .12)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .7)
	WHEN JobTitle = 'HR' THEN Salary + (Salary * .04)
	ELSE Salary + (Salary * .03)
END AS SalaryAfterRaise
FROM EmployeeDemographics JOIN EmployeeSalary 
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;*/

/*SELECT JobTitle,COUNT(JobTitle) 
FROM EmployeeDemographics JOIN EmployeeSalary 
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle HAVING COUNT(JobTitle) > 1;*/

/*SELECT JobTitle,AVG(Salary) 
FROM EmployeeDemographics ED JOIN EmployeeSalary ES 
ON ED.EmployeeID = ES.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 40000
ORDER BY AVG(Salary)*/

/*UPDATE EmployeeDemographics 
SET EmployeeID = 1012 
WHERE FirstName = 'Daniel' AND LastName = 'Larusso';*/

--SELECT * FROM EmployeeDemographics;

/*UPDATE EmployeeDemographics 
SET EmployeeID = 1099 , Age = 26
WHERE FirstName = 'Alison' AND LastName = 'Wonderland';*/

/*DELETE FROM EmployeeDemographics 
WHERE EmployeeID = 1005*/

--SELECT * FROM EmployeeDemographics;

/*SELECT COUNT(EmployeeID) AS Total_Employees
FROM EmployeeDemographics;*/

--SELECT FirstName + ' ' + LastName AS FullName FROM EmployeeDemographics;

/*SELECT ED.EmployeeID FROM EmployeeDemographics ED
JOIN EmployeeSalary ES 
ON ED.EmployeeID = ES.EmployeeID;*/

/*SELECT * FROM EmployeeDemographics;
SELECT * FROM EmployeeSalary;*/

/*SELECT FirstName,LastName,Gender,Salary,COUNT(GENDER) 
OVER (PARTITION BY Gender) as TotalGender FROM EmployeeDemographics ED
JOIN EmployeeSalary ES ON ED.EmployeeID = ES.EmployeeID;*/

/*SELECT Gender,COUNT(GENDER) 
FROM EmployeeDemographics ED
JOIN EmployeeSalary ES ON ED.EmployeeID = ES.EmployeeID
GROUP BY Gender;*/

--Common Table Expression--

/*WITH CTE_Employee as 
(
	SELECT FirstName,LastName,Gender,Salary,COUNT(Gender) 
	OVER (PARTITION BY Gender) as TotalGender,
	AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
	FROM EmployeeDemographics ED 
	JOIN EmployeeSalary ES 
	ON ED.EmployeeID = ES.EmployeeID
	WHERE Salary > '45000'
)*/

--SELECT * FROM CTE_Employee;
--SELECT FirstName,LastName FROM CTE_Employee;

--Temp Tables--

/*CREATE TABLE #temp_Employee (
	EmployeeID int,
	JobTitle varchar(100),
	Salary int
)*/

--SELECT * FROM #temp_Employee;

/*INSERT INTO #temp_Employee VALUES 
('1001','HR','45000'),('1002','Consultant','28000'),('1003','Receptionist','30000');*/

--SELECT * FROM #temp_Employee;

/*INSERT INTO #temp_Employee 
SELECT * FROM EmployeeSalary;*/

--SELECT * FROM #temp_Employee;

/*CREATE TABLE #Temp_Employee2(
	JobTitle varchar(50),
	EmployeesPerJob int,
	AvgAge int,
	AvgSalary int
);*/

/*INSERT INTO #Temp_Employee2 
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(salary)
FROM EmployeeDemographics ED JOIN EmployeeSalary ES
ON ED.EmployeeID = ES.EmployeeID
GROUP BY JobTitle;*/

--SELECT * FROM #Temp_Employee2;

/*CREATE TABLE EmployeeErrors(
	EmployeeID varchar(50),
	FirstName varchar(50),
	LastName varchar(50)
)

INSERT INTO EmployeeErrors VALUES 
('1001','Tobey','Maguire'),('1002','Sonny','Moore'),('1003','Ngolo','Kante');*/

/*INSERT INTO EmployeeErrors VALUES 
('1004','Magnusss','Carlsen'),('  1005','Devon','Conway'),('1006','PAul','Pogba - striker');*/

-- Trim , LTRIM , RTRIM 
/*SELECT EmployeeID , TRIM(EmployeeID) FROM EmployeeErrors;
SELECT EmployeeID , LTRIM(EmployeeID) FROM EmployeeErrors;
SELECT EmployeeID , RTRIM(EmployeeID) FROM EmployeeErrors;*/

-- Replace --
/*SELECT LastName , REPLACE(LastName,'- striker','') as LastNameFixed
FROM EmployeeErrors*/

-- Substring --
/*SELECT SUBSTRING(FirstName,1,4) FROM EmployeeErrors;*/

/*SELECT SUBSTRING(EE.FirstName,1,3),SUBSTRING(ED.FirstName,1,3) 
FROM EmployeeErrors EE JOIN EmployeeDemographics ED
ON SUBSTRING(EE.FirstName,1,3) = SUBSTRING(ED.FirstName,1,3);*/

--Upper and Lower--
/*SELECT FirstName, LOWER(FirstName) FROM EmployeeErrors;
SELECT FirstName, UPPER(FirstName) FROM EmployeeErrors;*/

-- Stored Procedure --

/*CREATE PROCEDURE TEST 
AS
SELECT * FROM EmployeeDemographics*/

--EXEC TEST;

-- Subqueries (Nested Queries) (in Select,From and Where Statement)

--SELECT * FROM EmployeeSalary;

--Subquery in SELECT
/*SELECT EmployeeID,Salary , 
(SELECT AVG(Salary) FROM EmployeeSalary) AS AllAvgSal
FROM EmployeeSalary;*/

--How to do it with Partition By
/*SELECT EmployeeID,Salary,AVG(Salary) OVER() AS AllAvgSal
FROM EmployeeSalary;*/

--Subquery in FROM
/*SELECT * FROM (SELECT EmployeeID,Salary,AVG(Salary) OVER ()
AS AllAvgSalary FROM EmployeSalary)*/

--Subquery in SELECT
/*SELECT EmployeeID,JobTitle,Salary 
FROM EmployeeSalary WHERE EmployeeID IN 
(SELECT EmployeeID FROM EmployeeDemographics WHERE Age >30);*/



