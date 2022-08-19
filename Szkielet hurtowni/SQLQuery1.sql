use DW_airport
GO

DROP TABLE PASSENGER_BOARDING;
DROP TABLE FLIGHT_BOARDING;
DROP TABLE Junk;
DROP TABLE Airlines;
DROP TABLE Flight;
DROP TABLE Employee;
DROP TABLE Time;
DROP TABLE Date;
DROP TABLE Passenger;


CREATE TABLE Passenger (
	ID_passenger INT IDENTITY(1,1) PRIMARY KEY,
	BK_passenger INT,
	Full_name VARCHAR(40),
	Nationality VARCHAR(60)
);

CREATE TABLE Date (
	ID_date INT IDENTITY(1,1) PRIMARY KEY,
	Date DATE UNIQUE,
	Year_ INT,
	Season VARCHAR(20),
	Month_ INT, 
	Month_name VARCHAR(20),
	Day_ INT CHECK(Day_ BETWEEN 1 AND 31),
	Day_name VARCHAR(12),
	Week_day_number INT
);

CREATE TABLE Time (
	ID_time INT IDENTITY(1,1) PRIMARY KEY,
	Time_ Time UNIQUE,
	Hour_ INT,
	Minutes_ INT,
	Seconds INT
);

CREATE TABLE Employee (
	ID_employee INT IDENTITY(1,1) PRIMARY KEY,
	BK_employee INT,
	Full_name VARCHAR(30),
	Position VARCHAR(30),
	Working_experience VARCHAR(15) /*category*/,
	Languages VARCHAR(50),
	Nationality VARCHAR(60),
	Active BIT /* SCD2 */
);

CREATE TABLE Flight (
	ID_flight INT IDENTITY(1,1) PRIMARY KEY,
	BK_flight INT,
	Distance VARCHAR(15) /* category */,
	Flight_length VARCHAR(15) /* category */,
	Destination VARCHAR(30),
	ID_Date INT REFERENCES Date
);

CREATE TABLE Airlines (
	ID_airlines INT IDENTITY(1,1) PRIMARY KEY,
	BK_airlines INT,
	Airline_name VARCHAR(50),
	Country VARCHAR(20),
	Headquarters VARCHAR(20)
);

CREATE TABLE Junk (
	ID_junk INT IDENTITY(1,1) PRIMARY KEY,
	Seat CHAR(4),
	On_board BIT
);

CREATE TABLE FLIGHT_BOARDING (
    ID_flight_boarding INT IDENTITY(1,1) primary key,
	ID_flight INT REFERENCES Flight NOT NULL,
	ID_airlines INT REFERENCES Airlines NOT NULL,
	Whole_boarding_time INT,
	Done_boardings INT,
	Possible_delay INT,
	Actual_dealy INT,
	UNIQUE (ID_flight, ID_airlines)
);

CREATE TABLE PASSENGER_BOARDING (
	ID_passenger INT REFERENCES Passenger NOT NULL,
	ID_employee INT REFERENCES Employee NOT NULL,
	ID_generation_time INT REFERENCES Time NOT NULL,
	ID_generation_date INT REFERENCES Date NOT NULL,
	ID_junk INT REFERENCES Junk NOT NULL,
	ID_boarding_time INT REFERENCES Time NOT NULL,
	ID_boarding_date INT REFERENCES Date NOT NULL,
	ID_flight_boarding INT REFERENCES FLIGHT_BOARDING NOT NULL,
	DutyFree_evaluation INT CHECK(DutyFree_evaluation >=1 AND DutyFree_evaluation <= 10),
	Employee_evaluation INT CHECK(Employee_evaluation >=1 AND Employee_evaluation <= 10),
	Time_evaluation INT CHECK(Time_evaluation >=1 AND Time_evaluation <= 10),
	Overall_opinion INT CHECK(Overall_opinion >=1 AND Overall_opinion <= 10),
	Boarding_time INT, 
	PRIMARY KEY(ID_passenger, ID_employee, ID_generation_time, ID_generation_date, ID_junk, ID_boarding_time, ID_boarding_date, ID_flight_boarding),
    UNIQUE (ID_passenger, ID_employee, ID_generation_time, ID_generation_date, ID_junk, ID_boarding_time, ID_boarding_date, ID_flight_boarding)
);

/*SELECT COUNT(*) FROM Flight;*/