SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.call_center' AS Table_Name FROM dbo.call_center UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.catalog_page' AS Table_Name FROM dbo.catalog_page UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.catalog_returns' AS Table_Name FROM dbo.catalog_returns UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.catalog_sales' AS Table_Name FROM dbo.catalog_sales UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.customer' AS Table_Name FROM dbo.customer UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.customer_address' AS Table_Name FROM dbo.customer_address UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.customer_demographics' AS Table_Name FROM dbo.customer_demographics UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.date_dim' AS Table_Name FROM dbo.date_dim UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.household_demographics' AS Table_Name FROM dbo.household_demographics UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.income_band' AS Table_Name FROM dbo.income_band UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.inventory' AS Table_Name FROM dbo.inventory UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.item' AS Table_Name FROM dbo.item UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.promotion' AS Table_Name FROM dbo.promotion UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.reason' AS Table_Name FROM dbo.reason UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.ship_mode' AS Table_Name FROM dbo.ship_mode UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.store' AS Table_Name FROM dbo.store UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.store_returns' AS Table_Name FROM dbo.store_returns UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.store_sales' AS Table_Name FROM dbo.store_sales UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.time_dim' AS Table_Name FROM dbo.time_dim UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.warehouse' AS Table_Name FROM dbo.warehouse UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.web_page' AS Table_Name FROM dbo.web_page UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.web_returns' AS Table_Name FROM dbo.web_returns UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.web_sales' AS Table_Name FROM dbo.web_sales UNION ALL
SELECT FORMAT(COUNT_BIG(*), '#,###') AS Record_Count, 'dbo.web_site' AS Table_Name FROM dbo.web_site