/* FACT - PASSENGER BOARDING */

USE DW_airport;
GO

IF (OBJECT_ID('passengerb_temp') IS NOT NULL) DROP VIEW passengerb_temp;
GO


CREATE VIEW passengerb_temp AS 
	SELECT 
		ISNULL(P.ID_passenger,-1) AS ID_passenger,
		ISNULL(E.ID_employee,-1) AS ID_employee,
		ISNULL(Air.ID_airlines,-1) AS ID_airlines,
		T2.ID_time AS ID_generation_time,
			CASE 
				WHEN ABS(DATEDIFF(HOUR,T2.Time_,T1.Time_)) >= 23 THEN (F.ID_Date+1)
				ELSE F.ID_Date
			END AS ID_generation_date, 
		ISNULL(ID_junk,-1) AS ID_junk,
		T1.ID_time AS ID_boarding_time,
		F.ID_Date AS ID_boarding_date,
		ID_flight_boarding AS ID_flight_boarding,
		DutyFree_evaluation AS DutyFree_evaluation,
		Staff_evaluation AS Employee_evaluation,
		Time_evaluation AS Time_evaluation,
		General_evaluation AS Overall_opinion,
		ABS(DATEDIFF(MINUTE,T1.Time_,T2.Time_)) AS Boarding_time
	FROM SuperAirport.dbo.Boarding_pass AS BP
	JOIN SuperAirport.dbo.Opinion AS OP ON BP.ID_number = OP.ID_number
	LEFT JOIN dbo.Passenger AS P ON BP.Passenger_ID = P.ID_passenger
    LEFT JOIN dbo.Employee AS E ON BP.Employee_ID =  E.BK_employee AND E.Active = 1
	LEFT JOIN dbo.Junk AS J ON BP.Seat = J.Seat AND BP.On_board = J.On_board
	LEFT JOIN dbo.Flight AS F ON BP.Flight_number = F.ID_flight
	JOIN SuperAirport.dbo.Flight AS SA_F ON F.ID_flight = SA_F.Flight_number
	JOIN SuperAirport.dbo.Flight_sketch AS FS ON SA_F.Flight_ID = FS.Flight_ID
	JOIN SuperAirport.dbo.Airline AS A ON FS.Airline_name = A.Airline_name
	LEFT JOIN dbo.Airlines AS Air ON A.Airline_name = Air.Airline_name
	JOIN dbo.FLIGHT_BOARDING AS FB ON FB.ID_airlines = Air.ID_airlines AND FB.ID_flight = F.ID_flight
	JOIN dbo.Time AS T1 ON BP.Boarding_time = T1.Time_ 
	JOIN dbo.Time AS T2 ON BP.Generation_time = T2.Time_ 

GO


MERGE PASSENGER_BOARDING AS TT
USING passengerb_temp AS ST
	 ON (	TT.ID_passenger = ST.ID_passenger AND
			TT.ID_employee = ST.ID_employee AND
			TT.ID_generation_time = ST.ID_generation_time AND
			TT.ID_junk = ST.ID_junk AND
			TT.ID_boarding_time = ST.ID_boarding_time AND
			TT.ID_boarding_date = ST.ID_boarding_date AND
			TT.ID_flight_boarding = ST.ID_flight_boarding)
			WHEN NOT MATCHED
				THEN INSERT (ID_passenger, ID_employee, ID_generation_time, ID_generation_date, ID_junk, ID_boarding_time, ID_boarding_date, ID_flight_boarding, DutyFree_evaluation, Employee_evaluation, Time_evaluation, Overall_opinion, Boarding_time)
							VALUES (ST.ID_passenger, ST.ID_employee, ST.ID_generation_time, ID_generation_date, ST.ID_junk, ST.ID_boarding_time, ST.ID_boarding_date, ST.ID_flight_boarding, ST.DutyFree_evaluation, ST.Employee_evaluation, ST.Time_evaluation, ST.Overall_opinion, ST.Boarding_time)
			WHEN NOT MATCHED BY SOURCE 
				THEN DELETE;
GO

DROP VIEW passengerb_temp;
