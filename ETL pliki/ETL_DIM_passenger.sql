/* PASSENGER DIMENSION */

USE DW_airport;

IF (OBJECT_ID('passenger_temp') IS NOT NULL) DROP VIEW passenger_temp;
GO

CREATE VIEW passenger_temp AS 
	SELECT Passenger_ID AS	BK_passenger, Nationality, CONCAT(Name,' ',Surname) AS Full_name
	FROM SuperAirport.dbo.Passenger;
GO

MERGE Passenger AS TT 
USING passenger_temp AS ST
	ON TT.BK_passenger = ST.BK_passenger AND TT.Nationality = ST.Nationality AND TT.Full_name = ST.Full_name
		WHEN NOT MATCHED
			THEN INSERT (BK_passenger, Nationality, Full_name)
				VALUES (ST.BK_passenger, ST.Nationality, ST.Full_name);
GO

DROP VIEW passenger_temp;


/*SELECT count(*) FROM Passenger;*/