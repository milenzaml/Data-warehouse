/* FACT - FLIGHT BOARDING ETL */

USE DW_airport;
GO

IF (OBJECT_ID('flightb_temp') IS NOT NULL) DROP VIEW flightb_temp;
GO


CREATE VIEW flightb_temp AS 
	SELECT 
		ID_flight AS ID_flight,
		ID_airlines AS ID_airlines,
		ABS(DATEDIFF(MINUTE, MAX(BP.Boarding_time), MIN(BP.Generation_time))+1350) AS Whole_boarding_time,
		SUM(BP.On_board) AS Done_boardings,
		MAX(SL.Possible_delay) AS Possible_delay,
		MAX(SL.Delay) AS Actual_delay
	FROM dbo.Flight AS X 
	JOIN SuperAirport.dbo.Flight AS Y ON X.ID_flight = Y.Flight_number
	JOIN SuperAirport.dbo.Flight_sketch AS Z ON Y.Flight_ID = Z.Flight_ID
	JOIN SuperAirport.dbo.Airline AS A ON Z.Airline_name = A.Airline_name
	JOIN dbo.Airlines AS Air ON A.Airline_name = Air.Airline_name
	JOIN SuperAirport.dbo.Boarding_pass AS BP ON X.ID_flight = BP.Flight_number
	JOIN SuperAirport.dbo.Slot AS SL ON X.ID_flight = SL.Flight_ID
	GROUP BY ID_flight, ID_airlines;
GO


MERGE FLIGHT_BOARDING AS TT
USING flightb_temp AS ST
	ON  (TT.ID_flight = ST.ID_flight AND
		TT.ID_airlines = ST.ID_airlines)
		WHEN NOT MATCHED
			THEN INSERT (ID_flight, ID_airlines, Whole_boarding_time, Done_boardings, Possible_delay, Actual_dealy)
				VALUES (ST.ID_flight, ST.ID_airlines, ST.Whole_boarding_time, ST.Done_boardings, ST.Possible_delay, ST.Actual_delay);
GO

DROP VIEW flightb_temp;


/*
SELECT COUNT(DISTINCT Flight_number) FROM SuperAirport.dbo.Boarding_pass;
SELECT COUNT(*) FROM FLIGHT_BOARDING;
SELECT * FROM FLIGHT_BOARDING;
SELECT SUM(Done_boardings) FROM FLIGHT_BOARDING;
SELECT SUM(On_board) FROM SuperAirport.dbo.Boarding_pass;
SELECT COUNT(*) FROM FLIGHT_BOARDING WHERE Actual_dealy > Possible_delay;
SELECT COUNT(*) FROM FLIGHT_BOARDING;
*/