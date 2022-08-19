/* TIME DIMENSION - CREATION OF TIMES */

USE [DW_airport]
GO


DECLARE @Time1 DATETIME = '2017-06-20 00:00:00'; 
DECLARE @Time2 DATETIME = '2017-06-20 23:59:59';

DECLARE @TimeTEMP DATETIME = @Time1;


WHILE @TimeTEMP <= @Time2
	BEGIN
		INSERT INTO [dbo].[Time] 
		([Time_],
		[Hour_],
		[Minutes_],
		[Seconds])

		VALUES 
		( CAST (@TimeTEMP AS TIME), /* Time */
		  CAST (DATEPART(HOUR, @TimeTEMP) AS INT), /* Hour */
		  CAST (DATEPART(MINUTE, @TimeTEMP) AS INT),  /* Minutes */
		  CAST (DATEPART(SECOND, @TimeTEMP) AS INT) /* Seconds */
		);  
		SET @TimeTEMP = DATEADD(SECOND, 1, @TimeTEMP);
	END
GO

/* SELECT COUNT(*) FROM Time;
SELECT * FROM Time; */