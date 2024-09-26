DROP PROCEDURE IF EXISTS dbo.RunBenchmarkSequential
GO

CREATE PROCEDURE dbo.RunBenchmarkSequential
AS
BEGIN

DECLARE @Loop			INT = 1
DECLARE @QueryCustomLog	NVARCHAR(MAX) = '[]'

WHILE @Loop <= 22
BEGIN
		
	DECLARE @QueryLog		VARCHAR(MAX)
	DECLARE @CurrentQuery 	VARCHAR(20) = 'TPC-H Query ' + RIGHT('00' + CONVERT(VARCHAR(2), @Loop) , 2)
	
	EXEC dbo.RunQuery @Query = @CurrentQuery, @QueryLog = @QueryLog OUTPUT

	SELECT @QueryCustomLog = JSON_MODIFY(@QueryCustomLog, 'append $', JSON_QUERY([value])) FROM OPENJSON(@QueryLog)

	SET @Loop = @Loop + 1
END

SELECT @QueryCustomLog AS QueryCustomLog

END
GO