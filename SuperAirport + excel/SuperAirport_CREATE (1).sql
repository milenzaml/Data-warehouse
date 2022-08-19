use SuperAirport
GO

DROP TABLE Opinion;
DROP TABLE Boarding_pass;
DROP TABLE Slot;
DROP TABLE Flight;
DROP TABLE Flight_sketch;
DROP TABLE Passenger;
DROP TABLE Employee;
DROP TABLE Airline;

CREATE TABLE Airline (
	Airline_name VARCHAR(50) PRIMARY KEY,
	Is_stationing INT NOT NULL CHECK(Is_stationing BETWEEN 0 AND 1)
);

CREATE TABLE Employee (
	Name VARCHAR(15) NOT NULL,
	Surname VARCHAR(15) NOT NULL,
	Airline_name VARCHAR(50) FOREIGN KEY REFERENCES Airline ON DELETE CASCADE,
	Employee_ID INT IDENTITY(1,1) PRIMARY KEY,
);

CREATE TABLE Passenger (
	Nationality VARCHAR(60) NOT NULL,
	Name VARCHAR(15) NOT NULL,
	Surname VARCHAR(15) NOT NULL,
	Phone_number VARCHAR(30),
	Passenger_ID INT IDENTITY(1,1) PRIMARY KEY
);
	
CREATE TABLE Flight_sketch (
	Flight_ID VARCHAR(8) PRIMARY KEY,
	Destination VARCHAR(25) NOT NULL,
	Flight_length INT NOT NULL,
	If_constant INT NOT NULL CHECK(If_constant BETWEEN 0 AND 1),
	Airline_name VARCHAR(50) FOREIGN KEY REFERENCES Airline ON DELETE CASCADE,
);

CREATE TABLE Flight ( 
	Captain VARCHAR(40) NOT NULL,
	If_takenOff INT NOT NULL CHECK(If_takenOff BETWEEN 0 AND 1),
	Distance INT NOT NULL,
	Plane VARCHAR(15) NOT NULL,
	Flight_ID VARCHAR(8) FOREIGN KEY REFERENCES Flight_sketch ON DELETE CASCADE,
	Flight_number INT IDENTITY(1,1) PRIMARY KEY
);

CREATE TABLE Slot ( 
	Runway INT NOT NULL,
	Slot_date DATE NOT NULL,
	Slot_time TIME NOT NULL,
	Possible_delay INT NOT NULL,
	Delay INT NOT NULL DEFAULT 0,
	Flight_ID INT FOREIGN KEY REFERENCES Flight ON DELETE CASCADE,
	Slot_number INT IDENTITY(1,1) PRIMARY KEY
);

CREATE TABLE Boarding_pass ( 
	QR_code VARCHAR(13),
	Generation_time TIME NOT NULL,
	Boarding_time TIME NOT NULL,
	Seat CHAR(3),
	On_board INT NOT NULL CHECK(On_board BETWEEN 0 AND 1),
	Flight_number INT FOREIGN KEY REFERENCES Flight ON DELETE CASCADE,
	Employee_ID INT FOREIGN KEY REFERENCES Employee,
	Passenger_ID INT FOREIGN KEY REFERENCES Passenger,
	ID_number INT IDENTITY(1,1) PRIMARY KEY,
);

CREATE TABLE Opinion (
	Time_evaluation INT CHECK(Time_evaluation >=1 AND Time_evaluation <= 10),
	Staff_evaluation INT CHECK(Staff_evaluation BETWEEN 1 AND 10),
	DutyFree_evaluation INT CHECK(DutyFree_evaluation BETWEEN 1 AND 10),
	Remarks VARCHAR(150) NULL,
	General_evaluation INT CHECK(General_evaluation BETWEEN 1 AND 10),
	ID_number INT FOREIGN KEY REFERENCES Boarding_pass,
	Opinion_no INT IDENTITY(1,1) PRIMARY KEY,
);




/*SELECT count(DISTINCT Flight_number) from SuperAirport.dbo.Boarding_pass;

INSERT INTO SuperAirport.dbo.Boarding_pass VALUES ('asdfghjh','12:12', '13:12', '23A', 1, 300,NULL,1);

INSERT INTO SuperAirport.dbo.Opinion VALUES (5,5,5,'YES',8,1010003);
SELECT * FROM SuperAirport.dbo.Boarding_pass JOIN  SuperAirport.dbo.Opinion  ON SuperAirport.dbo.Boarding_pass.ID_number = SuperAirport.dbo.Opinion.ID_number
WHERE QR_code = 'asdfghjh';*/