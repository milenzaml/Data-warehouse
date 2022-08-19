use DW_airport
GO

SET IDENTITY_INSERT dbo.Employee ON;  
GO 

INSERT INTO dbo.Employee(ID_employee, BK_employee, Full_name, Position, Working_experience, Languages,
						Nationality, Active) 
	VALUES(-1, -1, 'UNKNOWN', 'UNKNOWN', 'UNKNOWN', 'UNKNOWN', 'UNKNOWN', 0);
GO

SET IDENTITY_INSERT dbo.Employee OFF;  
GO 
SET IDENTITY_INSERT dbo.Passenger ON;  
GO 

INSERT INTO dbo.Passenger(ID_passenger, BK_passenger, Full_name, Nationality)
	VALUES(-1, -1, 'UNKNOWN', 'UNKNOWN');
GO

SET IDENTITY_INSERT dbo.Passenger OFF;  
GO 
SET IDENTITY_INSERT dbo.Airlines ON;  
GO 

INSERT INTO dbo.Airlines(ID_airlines, BK_airlines, Airline_name, Country, Headquarters)
	VALUES(-1, -1, 'UNKNOWN', 'UNKNOWN', 'UNKNOWN');
GO

SET IDENTITY_INSERT dbo.Airlines OFF;  
GO 
SET IDENTITY_INSERT dbo.Flight ON;  
GO 

INSERT INTO dbo.Flight(ID_flight, BK_flight, Distance, Flight_length, Destination, ID_Date)
	VALUES(-1, -1, 'UNKNOWN', 'UNKNOWN', 'UNKNOWN', NULL);
GO

SET IDENTITY_INSERT dbo.Flight OFF;  
GO 
SET IDENTITY_INSERT dbo.Junk ON;  
GO 

INSERT INTO dbo.Junk(ID_junk, Seat, On_board)
	VALUES(-1, 'UNK', 0);
GO

SET IDENTITY_INSERT dbo.Junk OFF;  
GO 
SET IDENTITY_INSERT dbo.Date ON;  
GO 

INSERT INTO dbo.Date(ID_date, Date, Year_, Season, Month_, Month_name, Day_, Day_name, Week_day_number)
	VALUES(-1, NULL, 0, 'UNKNOWN', 0,'UNKNOWN', NULL,'UNKNOWN',0);
GO



