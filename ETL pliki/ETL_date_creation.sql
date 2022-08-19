/* DATE DIMENSION - CREATION OF DATES */

USE DW_airport
GO

DECLARE @Date1 DATE = '2015-01-01'; 
DECLARE @Date2 DATE = '2021-12-31';
DECLARE @DateTEMP DATETIME = @Date1;

WHILE @DateTEMP <= @Date2
	BEGIN
		INSERT INTO [dbo].[Date] 
			([Date],
			[Year_],
			[Season],
			[Month_],
			[Month_name],
			[Day_],
			[Day_name],
			[Week_day_number])

		VALUES 
		 (@DateTEMP,
		  CAST (YEAR(@DateTEMP) AS INT),
		  CASE 
				WHEN MONTH(@DateTEMP) BETWEEN 6 AND 9 THEN 'Summer Holiday'
				WHEN MONTH(@DateTEMP) BETWEEN 1 AND 3 THEN 'Winter Holiday'
				ELSE 'Off Season'
			END,
		  CAST (Month(@DateTEMP) AS INT), 
		  CAST (DATENAME(month, @DateTEMP) AS VARCHAR(20)), 
		  CAST (DAY(@DateTEMP) AS INT), 
		  CAST (DATENAME(dw,@DateTEMP) AS VARCHAR(12)),
		  CAST (DATEPART(dw, @DateTEMP) AS INT) 
		);  
		SET @DateTEMP = DATEADD(DAY, 1, @DateTEMP);
	END
GO

SELECT * FROM Date;