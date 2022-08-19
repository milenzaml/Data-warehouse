use SuperAirport

/*Time 1*/
BULK INSERT Airline FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\CSV files to database\airline.bulk' WITH (FIELDTERMINATOR='|', ROWTERMINATOR='\n')                  
BULK INSERT Employee FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\CSV files to database\employeesidentity.csv' WITH (FIELDTERMINATOR=',', ROWTERMINATOR='\n')        
BULK INSERT Passenger FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\CSV files to database\passengersidentity.csv' WITH (FIELDTERMINATOR=',', ROWTERMINATOR='\n')      
BULK INSERT Flight_sketch FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\CSV files to database\sketchestsv.tsv' WITH (FIELDTERMINATOR='	', ROWTERMINATOR='\n',  FIRSTROW = 2)            
BULK INSERT Flight FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\CSV files to database\flights2.csv' WITH (FIELDTERMINATOR=',', ROWTERMINATOR='\n', FIRSTROW = 2)            
BULK INSERT Slot FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\CSV files to database\slots3.csv' WITH (FIELDTERMINATOR=',', ROWTERMINATOR='\n', FIRSTROW = 2)                
BULK INSERT Boarding_pass FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\CSV files to database\boardingT1.csv' WITH (FIELDTERMINATOR=',', ROWTERMINATOR='\n', FIRSTROW = 2)
BULK INSERT Opinion FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\CSV files to database\opinion.csv' WITH (FIELDTERMINATOR=',', ROWTERMINATOR='\n')  

/*select count(*) from Flight;*/
