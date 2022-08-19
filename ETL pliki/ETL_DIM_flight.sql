/* FLIGHTS DIMENSION */

USE DW_airport;
GO

IF (OBJECT_ID('flight_temp') IS NOT NULL) DROP VIEW flight_temp;
GO

CREATE VIEW flight_temp AS 
	SELECT Flight_number AS BK_flight, 
	CASE 
		WHEN Distance BETWEEN 0 AND 1500 THEN 'Short'
		WHEN Distance BETWEEN 1500 AND 3500 THEN 'Medium'
		WHEN Distance BETWEEN 3500 AND 6500 THEN 'Long'
		ELSE 'Very long'
	END AS Distance, 
	CASE 
		WHEN Flight_length BETWEEN 0 AND 3 THEN 'Short'
		WHEN Flight_length BETWEEN 3 AND 6 THEN 'Medium'
		WHEN Flight_length BETWEEN 6 AND 12 THEN 'Long'
		ELSE 'Very long'
	END AS Flight_length, 
	Destination AS Destination, Date.ID_date AS ID_date
	FROM SuperAirport.dbo.Flight JOIN SuperAirport.dbo.Flight_sketch 
	ON  SuperAirport.dbo.Flight.Flight_ID = SuperAirport.dbo.Flight_sketch.Flight_ID 
	JOIN SuperAirport.dbo.Slot 
	ON SuperAirport.dbo.Flight.Flight_number = SuperAirport.dbo.Slot.Flight_ID
	JOIN Date 
	ON SuperAirport.dbo.Slot.Slot_date = DW_airport.dbo.Date.Date;
GO


MERGE Flight AS TT 
USING flight_temp AS ST
	ON TT.BK_flight = ST.BK_flight AND TT.Distance = ST.Distance AND TT.Flight_length = ST.Flight_length AND TT.Destination = ST.Destination AND TT.ID_date = ST.ID_date
		WHEN NOT MATCHED 
			THEN INSERT (BK_flight, Distance, Flight_length, Destination, ID_date)
				VALUES(ST.BK_flight, ST.Distance, ST.Flight_length, ST.Destination, ST.ID_date);
GO

DROP VIEW flight_temp;

