DECLARE @ScaleFactorInGB INT = 1
/*
Valid Scale Factors: 
	1 GB:	1
	1 TB:	1000
	3 TB:	3000
	10 TB:	10000
	30 TB:  30000
	100 TB:	100000
*/


DECLARE
	@count_call_center 				BIGINT,
	@count_catalog_page 			BIGINT,
	@count_catalog_returns 			BIGINT,
	@count_catalog_sales 			BIGINT,
	@count_customer 				BIGINT,
	@count_customer_address 		BIGINT,
	@count_customer_demographics 	BIGINT,
	@count_date_dim 				BIGINT,
	@count_household_demographics 	BIGINT,
	@count_income_band 				BIGINT,
	@count_inventory 				BIGINT,
	@count_item 					BIGINT,
	@count_promotion 				BIGINT,
	@count_reason 					BIGINT,
	@count_ship_mode 				BIGINT,
	@count_store 					BIGINT,
	@count_store_returns 			BIGINT,
	@count_store_sales 				BIGINT,
	@count_time_dim 				BIGINT,
	@count_warehouse 				BIGINT,
	@count_web_page 				BIGINT,
	@count_web_returns 				BIGINT,
	@count_web_sales 				BIGINT,
	@count_web_site 				BIGINT


IF @ScaleFactorInGB = 1
	BEGIN
		SET @count_call_center 				= 6
		SET @count_catalog_page 			= 11718
		SET @count_catalog_returns 			= 144067
		SET @count_catalog_sales 			= 1441548
		SET @count_customer 				= 100000
		SET @count_customer_address 		= 50000
		SET @count_customer_demographics	= 1920800
		SET @count_date_dim					= 73049
		SET @count_household_demographics	= 7200
		SET @count_income_band				= 20
		SET @count_inventory 				= 11745000
		SET @count_item 					= 18000
		SET @count_promotion 				= 300
		SET @count_reason 					= 35
		SET @count_ship_mode				= 20
		SET @count_store 					= 12
		SET @count_store_returns 			= 287512
		SET @count_store_sales 				= 2880404
		SET @count_time_dim					= 86400
		SET @count_warehouse 				= 5
		SET @count_web_page 				= 60
		SET @count_web_returns 				= 71763
		SET @count_web_sales 				= 719384
		SET @count_web_site 				= 30
	END


IF @ScaleFactorInGB = 1000
	BEGIN
		SET @count_call_center 				= 42
		SET @count_catalog_page 			= 30000
		SET @count_catalog_returns 			= 143996756
		SET @count_catalog_sales 			= 1439980416
		SET @count_customer 				= 12000000
		SET @count_customer_address 		= 6000000
		SET @count_customer_demographics	= 1920800
		SET @count_date_dim					= 73049
		SET @count_household_demographics	= 7200
		SET @count_income_band				= 20
		SET @count_inventory 				= 783000000
		SET @count_item 					= 300000
		SET @count_promotion 				= 1500
		SET @count_reason 					= 65
		SET @count_ship_mode				= 20
		SET @count_store 					= 1002
		SET @count_store_returns 			= 287999764
		SET @count_store_sales 				= 2879987999
		SET @count_time_dim					= 86400
		SET @count_warehouse 				= 20
		SET @count_web_page 				= 3000
		SET @count_web_returns 				= 71997522
		SET @count_web_sales 				= 720000376
		SET @count_web_site 				= 54
	END


IF @ScaleFactorInGB = 3000
	BEGIN
		SET @count_call_center 				= 48
		SET @count_catalog_page 			= 36000
		SET @count_catalog_returns 			= 432018033
		SET @count_catalog_sales 			= 4320078880
		SET @count_customer 				= 30000000
		SET @count_customer_address 		= 15000000
		SET @count_customer_demographics	= 1920800
		SET @count_date_dim					= 73049
		SET @count_household_demographics	= 7200
		SET @count_income_band				= 20
		SET @count_inventory 				= 1033560000
		SET @count_item 					= 360000
		SET @count_promotion 				= 1800
		SET @count_reason 					= 67
		SET @count_ship_mode				= 20
		SET @count_store 					= 1350
		SET @count_store_returns 			= 863989652
		SET @count_store_sales 				= 8639936081
		SET @count_time_dim					= 86400
		SET @count_warehouse 				= 22
		SET @count_web_page 				= 3600
		SET @count_web_returns 				= 216003761
		SET @count_web_sales 				= 2159968881
		SET @count_web_site 				= 66
	END


IF @ScaleFactorInGB = 10000
	BEGIN
		SET @count_call_center 				= 54
		SET @count_catalog_page 			= 40000
		SET @count_catalog_returns 			= 1440033112
		SET @count_catalog_sales 			= 14399964710
		SET @count_customer 				= 65000000
		SET @count_customer_address 		= 32500000
		SET @count_customer_demographics	= 1920800
		SET @count_date_dim					= 73049
		SET @count_household_demographics	= 7200
		SET @count_income_band				= 20
		SET @count_inventory 				= 1311525000
		SET @count_item 					= 402000
		SET @count_promotion 				= 2000
		SET @count_reason 					= 70
		SET @count_ship_mode				= 20
		SET @count_store 					= 1500
		SET @count_store_returns 			= 2879970104
		SET @count_store_sales 				= 28799983563
		SET @count_time_dim					= 86400
		SET @count_warehouse 				= 25
		SET @count_web_page 				= 4002
		SET @count_web_returns 				= 720020485
		SET @count_web_sales 				= 7199963324
		SET @count_web_site 				= 78
	END


IF @ScaleFactorInGB = 30000
	BEGIN
		SET @count_call_center 				= 60
		SET @count_catalog_page 			= 46000
		SET @count_catalog_returns 			= 4319925093
		SET @count_catalog_sales 			= 43200404822
		SET @count_customer 				= 80000000
		SET @count_customer_address 		= 40000000
		SET @count_customer_demographics	= 1920800
		SET @count_date_dim					= 73049
		SET @count_household_demographics	= 7200
		SET @count_income_band				= 20
		SET @count_inventory 				= 1627857000
		SET @count_item 					= 462000
		SET @count_promotion 				= 2300
		SET @count_reason 					= 72
		SET @count_ship_mode				= 20
		SET @count_store 					= 1704
		SET @count_store_returns 			= 8639952111
		SET @count_store_sales 				= 86399341874
		SET @count_time_dim					= 86400
		SET @count_warehouse 				= 27
		SET @count_web_page 				= 4602
		SET @count_web_returns 				= 2160007345
		SET @count_web_sales 				= 21600036511
		SET @count_web_site 				= 84
	END


IF @ScaleFactorInGB = 100000
	BEGIN
		SET @count_call_center 				= 60
		SET @count_catalog_page 			= 50000
		SET @count_catalog_returns 			= 14400175879
		SET @count_catalog_sales 			= 143999334399
		SET @count_customer 				= 100000000
		SET @count_customer_address 		= 50000000
		SET @count_customer_demographics	= 1920800
		SET @count_date_dim					= 73049
		SET @count_household_demographics	= 7200
		SET @count_income_band				= 20
		SET @count_inventory 				= 1965337830
		SET @count_item 					= 502000
		SET @count_promotion 				= 2500
		SET @count_reason 					= 75
		SET @count_ship_mode				= 20
		SET @count_store 					= 1902
		SET @count_store_returns 			= 28800018820
		SET @count_store_sales 				= 287997818084
		SET @count_time_dim					= 86400
		SET @count_warehouse 				= 30
		SET @count_web_page 				= 5004
		SET @count_web_returns 				= 7199904459
		SET @count_web_sales 				= 71999670164
		SET @count_web_site 				= 96
	END


; WITH RecordCounts AS
	(
		SELECT 'dbo.call_center' 			AS TableName, COUNT_BIG(*) AS RecordCount, @count_call_center 				AS ExpectedRecordCount FROM dbo.call_center 			UNION ALL
		SELECT 'dbo.catalog_page' 			AS TableName, COUNT_BIG(*) AS RecordCount, @count_catalog_page 				AS ExpectedRecordCount FROM dbo.catalog_page 			UNION ALL
		SELECT 'dbo.catalog_returns' 		AS TableName, COUNT_BIG(*) AS RecordCount, @count_catalog_returns 			AS ExpectedRecordCount FROM dbo.catalog_returns 		UNION ALL
		SELECT 'dbo.catalog_sales' 			AS TableName, COUNT_BIG(*) AS RecordCount, @count_catalog_sales 			AS ExpectedRecordCount FROM dbo.catalog_sales 			UNION ALL
		SELECT 'dbo.customer' 				AS TableName, COUNT_BIG(*) AS RecordCount, @count_customer 					AS ExpectedRecordCount FROM dbo.customer 				UNION ALL
		SELECT 'dbo.customer_address' 		AS TableName, COUNT_BIG(*) AS RecordCount, @count_customer_address 			AS ExpectedRecordCount FROM dbo.customer_address 		UNION ALL
		SELECT 'dbo.customer_demographics' 	AS TableName, COUNT_BIG(*) AS RecordCount, @count_customer_demographics 	AS ExpectedRecordCount FROM dbo.customer_demographics 	UNION ALL
		SELECT 'dbo.date_dim' 				AS TableName, COUNT_BIG(*) AS RecordCount, @count_date_dim 					AS ExpectedRecordCount FROM dbo.date_dim 				UNION ALL
		SELECT 'dbo.household_demographics'	AS TableName, COUNT_BIG(*) AS RecordCount, @count_household_demographics 	AS ExpectedRecordCount FROM dbo.household_demographics	UNION ALL
		SELECT 'dbo.income_band' 			AS TableName, COUNT_BIG(*) AS RecordCount, @count_income_band 				AS ExpectedRecordCount FROM dbo.income_band 			UNION ALL
		SELECT 'dbo.inventory' 				AS TableName, COUNT_BIG(*) AS RecordCount, @count_inventory 				AS ExpectedRecordCount FROM dbo.inventory 				UNION ALL
		SELECT 'dbo.item' 					AS TableName, COUNT_BIG(*) AS RecordCount, @count_item 						AS ExpectedRecordCount FROM dbo.item 					UNION ALL
		SELECT 'dbo.promotion' 				AS TableName, COUNT_BIG(*) AS RecordCount, @count_promotion 				AS ExpectedRecordCount FROM dbo.promotion 				UNION ALL
		SELECT 'dbo.reason' 				AS TableName, COUNT_BIG(*) AS RecordCount, @count_reason 					AS ExpectedRecordCount FROM dbo.reason 					UNION ALL
		SELECT 'dbo.ship_mode' 				AS TableName, COUNT_BIG(*) AS RecordCount, @count_ship_mode 				AS ExpectedRecordCount FROM dbo.ship_mode 				UNION ALL
		SELECT 'dbo.store' 					AS TableName, COUNT_BIG(*) AS RecordCount, @count_store 					AS ExpectedRecordCount FROM dbo.store 					UNION ALL
		SELECT 'dbo.store_returns' 			AS TableName, COUNT_BIG(*) AS RecordCount, @count_store_returns 			AS ExpectedRecordCount FROM dbo.store_returns 			UNION ALL
		SELECT 'dbo.store_sales' 			AS TableName, COUNT_BIG(*) AS RecordCount, @count_store_sales 				AS ExpectedRecordCount FROM dbo.store_sales 			UNION ALL
		SELECT 'dbo.time_dim' 				AS TableName, COUNT_BIG(*) AS RecordCount, @count_time_dim 					AS ExpectedRecordCount FROM dbo.time_dim 				UNION ALL
		SELECT 'dbo.warehouse' 				AS TableName, COUNT_BIG(*) AS RecordCount, @count_warehouse 				AS ExpectedRecordCount FROM dbo.warehouse 				UNION ALL
		SELECT 'dbo.web_page' 				AS TableName, COUNT_BIG(*) AS RecordCount, @count_web_page 					AS ExpectedRecordCount FROM dbo.web_page 				UNION ALL
		SELECT 'dbo.web_returns' 			AS TableName, COUNT_BIG(*) AS RecordCount, @count_web_returns 				AS ExpectedRecordCount FROM dbo.web_returns 			UNION ALL
		SELECT 'dbo.web_sales' 				AS TableName, COUNT_BIG(*) AS RecordCount, @count_web_sales 				AS ExpectedRecordCount FROM dbo.web_sales 				UNION ALL
		SELECT 'dbo.web_site' 				AS TableName, COUNT_BIG(*) AS RecordCount, @count_web_site 					AS ExpectedRecordCount FROM dbo.web_site	
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