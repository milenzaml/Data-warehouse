use SuperAirport

/*Time 2*/

BULK INSERT Employee FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\CSV files to database\empidentity.bulk' WITH (FIELDTERMINATOR='|', ROWTERMINATOR='\n')        
BULK INSERT Passenger FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\CSV files to database\passengers.csv' WITH (FIELDTERMINATOR=',', ROWTERMINATOR='\n', FIRSTROW = 2)   
BULK INSERT Slot FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\CSV files to database\slotsT2.csv' WITH (FIELDTERMINATOR=',', ROWTERMINATOR='\n', FIRSTROW = 2)   
BULK INSERT Flight FROM 'D:\PYCHARM\AI_LAB_1_180477\flightsT2a.csv' WITH (FIELDTERMINATOR=',', ROWTERMINATOR='\n', FIRSTROW = 2)         
BULK INSERT Boarding_pass FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\CSV files to database\boardingT2.csv' WITH (FIELDTERMINATOR=',', ROWTERMINATOR='\n', FIRSTROW = 2) 
BULK INSERT Opinion FROM 'C:\Users\zamly\Desktop\ID\AirportDATA\CSV files to database\opinionsT2.csv' WITH (FIELDTERMINATOR=',', ROWTERMINATOR='\n', FIRSTROW = 2)

