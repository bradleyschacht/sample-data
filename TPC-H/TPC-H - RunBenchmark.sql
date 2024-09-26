DROP PROCEDURE IF EXISTS dbo.RunBenchmark
GO

CREATE PROCEDURE dbo.RunBenchmark
AS
BEGIN

DECLARE @Loop			INT = 1
DECLARE @QueryCustomLog	NVARCHAR(MAX) = '[]'

WHILE @Loop <= 22
BEGIN
		
	DECLARE @QueryLog				VARCHAR(MAX)
	DECLARE @AdditionalInformation 	VARCHAR(MAX) = (SELECT 'Spec' AS QueryOrderType, @Loop AS QueryOrder FOR JSON PATH)
	DECLARE @CurrentQuery 			VARCHAR(20) = 'TPC-H Query ' +
		CASE 
			WHEN @Loop = 1  THEN '14'
			WHEN @Loop = 2  THEN '02'
			WHEN @Loop = 3  THEN '09'
			WHEN @Loop = 4  THEN '20'
			WHEN @Loop = 5  THEN '06'
			WHEN @Loop = 6  THEN '17'
			WHEN @Loop = 7  THEN '18'
			WHEN @Loop = 8  THEN '08'
			WHEN @Loop = 9  THEN '21'
			WHEN @Loop = 10 THEN '13'
			WHEN @Loop = 11 THEN '03'
			WHEN @Loop = 12 THEN '22'
			WHEN @Loop = 13 THEN '16'
			WHEN @Loop = 14 THEN '04'
			WHEN @Loop = 15 THEN '11'
			WHEN @Loop = 16 THEN '15'
			WHEN @Loop = 17 THEN '01'
			WHEN @Loop = 18 THEN '10'
			WHEN @Loop = 19 THEN '19'
			WHEN @Loop = 20 THEN '05'
			WHEN @Loop = 21 THEN '07'
			WHEN @Loop = 22 THEN '12'
		END
	
	EXEC dbo.RunQuery @Query = @CurrentQuery, @AdditionalInformation = @AdditionalInformation, @QueryLog = @QueryLog OUTPUT

	SELECT @QueryCustomLog = JSON_MODIFY(@QueryCustomLog, 'append $', JSON_QUERY([value])) FROM OPENJSON(@QueryLog)

	SET @Loop = @Loop + 1
END

SELECT @QueryCustomLog AS QueryCustomLog

END
GO