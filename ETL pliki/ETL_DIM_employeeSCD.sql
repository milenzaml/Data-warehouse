/* EMPLOYEE DIMENSION - SCD OF TYPE 2, excel (tsv) file load*/

USE DW_airport;
GO

IF (OBJECT_ID('employee_temp') IS NOT NULL) DROP TABLE employee_temp;
GO

CREATE TABLE employee_temp(
	Airline_name VARCHAR(50),
	Working_id INT,
	name VARCHAR(15),
	surname VARCHAR(15),
	position varchar(30),
	phone varchar(25),
	experience INT,
	contractuntil DATE,
	Nationality VARCHAR(60),
	languages VARCHAR(50)
) 
GO

/*TIME T1
BULK INSERT dbo.employee_temp FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\employees1tsv.tsv'
	WITH (FIELDTERMINATOR = '	', ROWTERMINATOR='\n', FIRSTROW = 2);
GO*/

/* TIME T2*/
BULK INSERT dbo.employee_temp FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\employees2.tsv'
	WITH (FIELDTERMINATOR = '	', ROWTERMINATOR='\n', FIRSTROW = 2);
GO



IF (object_id('employeesETL') IS NOT NULL) DROP VIEW employeesETL;
GO

CREATE VIEW employeesETL AS
	SELECT 
		Working_id AS BK_employee, 
		CONCAT(name, ' ', surname) AS Full_name, 
		position AS Position,
		CASE 
			WHEN experience BETWEEN 0 AND 5 THEN 'short'
			ELSE 'long'
		END AS Working_experience, 
		languages AS Languages,
		Nationality
	FROM dbo.employee_temp;
GO


ALTER TABLE employee_temp DROP COLUMN phone, Airline_name, contractuntil;
GO

MERGE Employee as TT
	USING employeesETL as ST
		ON TT.BK_employee = ST.BK_employee
			WHEN NOT MATCHED
				THEN
					INSERT (BK_employee, Full_name, Position, Working_experience, Languages, Nationality, Active)
					VALUES (ST.BK_employee, ST.Full_name, ST.Position, ST.Working_experience, ST.Languages, ST.Nationality, 1)
			WHEN MATCHED
				 AND (ST.Full_name <> TT.Full_name 
					 OR ST.Position <> TT.Position 
					 OR ST.Working_experience <> TT.Working_experience
				     OR ST.Languages <> TT.Languages
					 OR ST.Nationality <> TT.Nationality) /* if any attribute differs */
						THEN UPDATE SET TT.Active = 0
			WHEN NOT MATCHED BY SOURCE
				AND TT.BK_employee != -1 /* do not update the UNKNOWN tuple */
					THEN UPDATE SET TT.Active = 0;


/* INSERTING CHANGED ROWS TO THE Employee TABLE */
INSERT INTO Employee (BK_employee, Full_name, Position, Working_experience, Languages, Nationality, Active)
	SELECT BK_employee, Full_name, Position, Working_experience, Languages, Nationality, 1
		FROM employeesETL
	EXCEPT
	SELECT BK_employee, Full_name, Position, Working_experience, Languages, Nationality, Active
		FROM Employee;

DROP VIEW employeesETL
GO

DROP TABLE employee_temp
GO

/*SELECT * FROM Employee;*/


