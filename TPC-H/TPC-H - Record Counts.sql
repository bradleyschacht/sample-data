DECLARE @ScaleFactorInGB INT = 1


DECLARE
	@count_customer 	BIGINT,
	@count_lineitem 	BIGINT,
	@count_nation 		BIGINT,
	@count_orders 		BIGINT,
	@count_part 		BIGINT,
	@count_partsupp 	BIGINT,
	@count_region 		BIGINT,
	@count_supplier 	BIGINT


SET	@count_customer 	= 150000. 	* @ScaleFactorInGB
SET	@count_lineitem 	= 6000000. 	* @ScaleFactorInGB
SET	@count_nation 		= 25
SET	@count_orders 		= 1500000. 	* @ScaleFactorInGB
SET	@count_part 		= 200000. 	* @ScaleFactorInGB
SET	@count_partsupp 	= 800000. 	* @ScaleFactorInGB
SET	@count_region 		= 5
SET	@count_supplier 	= 10000. 	* @ScaleFactorInGB


; WITH RecordCounts AS
	(
		SELECT 'dbo.customer' 	AS TableName, COUNT_BIG(*) AS RecordCount, @count_customer 	AS ExpectedRecordCount FROM dbo.customer 	UNION ALL
		SELECT 'dbo.lineitem' 	AS TableName, COUNT_BIG(*) AS RecordCount, @count_lineitem 	AS ExpectedRecordCount FROM dbo.lineitem 	UNION ALL
		SELECT 'dbo.nation'		AS TableName, COUNT_BIG(*) AS RecordCount, @count_nation 	AS ExpectedRecordCount FROM dbo.nation 		UNION ALL
		SELECT 'dbo.orders' 	AS TableName, COUNT_BIG(*) AS RecordCount, @count_orders 	AS ExpectedRecordCount FROM dbo.orders 		UNION ALL
		SELECT 'dbo.part' 		AS TableName, COUNT_BIG(*) AS RecordCount, @count_part 		AS ExpectedRecordCount FROM dbo.part 		UNION ALL
		SELECT 'dbo.partsupp' 	AS TableName, COUNT_BIG(*) AS RecordCount, @count_partsupp 	AS ExpectedRecordCount FROM dbo.partsupp 	UNION ALL
		SELECT 'dbo.region' 	AS TableName, COUNT_BIG(*) AS RecordCount, @count_region 	AS ExpectedRecordCount FROM dbo.region 		UNION ALL
		SELECT 'dbo.supplier' 	AS TableName, COUNT_BIG(*) AS RecordCount, @count_supplier 	AS ExpectedRecordCount FROM dbo.supplier
	)


SELECT
	'__ Total Record Count __' 																AS TableName,
	FORMAT(SUM(RecordCount), 'N0') 															AS RecordCount,
	FORMAT(SUM(ExpectedRecordCount), 'N0') 													AS ExpectedRecordCount,
	FORMAT(SUM(RecordCount - ExpectedRecordCount), 'N0')									AS RecordCountDifference,
	FORMAT(1.0 * SUM(RecordCount - ExpectedRecordCount) / SUM(ExpectedRecordCount), 'P4')	AS RecordPercentageDifference
FROM RecordCounts

UNION ALL 

SELECT
	TableName,
	FORMAT(RecordCount, 'N0') 																AS RecordCount,
	FORMAT(ExpectedRecordCount, 'N0') 														AS ExpectedRecordCount, 
	FORMAT(RecordCount - ExpectedRecordCount, 'N0') 										AS RecordCountDifference,
	FORMAT((1.0 * RecordCount - ExpectedRecordCount) / ExpectedRecordCount, 'P4')			AS RecordPercentageDifference
FROM RecordCounts
ORDER BY TableName