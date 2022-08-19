/* JUNK DIMENSION - CREATION OF DATES */

USE [DW_airport]
GO

DECLARE @ROW INT = 1; 
DECLARE @ROWEND INT = 40;
DECLARE @SEAT INT = 65; /* A letter in ASCII*/
DECLARE @SEATEND INT = 73; /*I letter in ASCII*/

DECLARE @rowTEMP INT = @ROW;

WHILE @rowTEMP <= @ROWEND
	BEGIN
	DECLARE @seatTEMP INT = @SEAT;
	WHILE @seatTEMP <= @SEATEND
		BEGIN
		DECLARE @binaryBOARD INT = 0;
		WHILE @binaryBOARD <= 1
			BEGIN
				INSERT INTO [dbo].[Junk] 
				([Seat],
				[On_board])

				VALUES 
				( CAST ((CAST (@rowTEMP AS VARCHAR)) + Char(@seatTEMP) AS VARCHAR(4)),
				  CAST (@binaryBOARD AS BIT)
				);  
				SET @binaryBOARD = @binaryBOARD +1;
			END
			SET @seatTEMP = @seatTEMP + 1;
		END
		SET @rowTEMP = @rowTEMP + 1;
	END
GO



/* SELECT * FROM Junk; */