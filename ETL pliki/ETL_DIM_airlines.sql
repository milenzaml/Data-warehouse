/* AIRLINES DIMENSION, excel (tsv) file load */

USE DW_airport;
GO

IF (OBJECT_ID('airlines_temp') IS NOT NULL) DROP TABLE airlines_temp;

CREATE TABLE airlines_temp(
	Airline_name VARCHAR(50) PRIMARY KEY,
	Country VARCHAR(80),
	Headquarters VARCHAR(40),
	Type VARCHAR(10),
	Plane_fleet INT,
	Worers_no INT,
	contract_length INT,
	mail VARCHAR(50),
	Stake INT,
	Airline_ID INT UNIQUE
) 
GO

BULK INSERT dbo.airlines_temp
FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\airlines.tsv'
	WITH (FIELDTERMINATOR = '	', ROWTERMINATOR='\n', FIRSTROW = 2);
GO


ALTER TABLE airlines_temp
DROP COLUMN Type, Plane_fleet, worers_no, contract_length, mail, Stake;

UPDATE airlines_temp
	SET Country = SUBSTRING(Country, 1, 20);
UPDATE airlines_temp
	SET Headquarters = SUBSTRING(Headquarters, 1, 20);
GO 


MERGE Airlines AS TT 
USING airlines_temp AS ST
	ON TT.Airline_name = ST.Airline_name AND TT.Country = ST.Country AND TT.Headquarters = ST.Headquarters
		WHEN NOT MATCHED
			THEN INSERT (BK_airlines, Airline_name, Country, Headquarters)
				VALUES(ST.Airline_ID, ST.Airline_name, ST.Country, ST.Headquarters);
GO


DROP TABLE airlines_temp;

/*SELECT * FROM Airlines;*/

