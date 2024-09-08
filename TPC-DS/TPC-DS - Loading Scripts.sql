/*  Use this section to load the data warehouse from tables in the lakehouse.  */
DECLARE @LakehouseName VARCHAR(250) = ''

EXEC ('
INSERT INTO dbo.call_center 			SELECT * FROM ' + @LakehouseName + '.dbo.call_center;
INSERT INTO dbo.catalog_page 			SELECT * FROM ' + @LakehouseName + '.dbo.catalog_page;
INSERT INTO dbo.catalog_returns 		SELECT * FROM ' + @LakehouseName + '.dbo.catalog_returns;
INSERT INTO dbo.catalog_sales 			SELECT * FROM ' + @LakehouseName + '.dbo.catalog_sales;
INSERT INTO dbo.customer 				SELECT * FROM ' + @LakehouseName + '.dbo.customer;
INSERT INTO dbo.customer_address 		SELECT * FROM ' + @LakehouseName + '.dbo.customer_address;
INSERT INTO dbo.customer_demographics 	SELECT * FROM ' + @LakehouseName + '.dbo.customer_demographics;
INSERT INTO dbo.date_dim 				SELECT * FROM ' + @LakehouseName + '.dbo.date_dim;
INSERT INTO dbo.household_demographics 	SELECT * FROM ' + @LakehouseName + '.dbo.household_demographics;
INSERT INTO dbo.income_band 			SELECT * FROM ' + @LakehouseName + '.dbo.income_band;
INSERT INTO dbo.inventory 				SELECT * FROM ' + @LakehouseName + '.dbo.inventory;
INSERT INTO dbo.item 					SELECT * FROM ' + @LakehouseName + '.dbo.item;
INSERT INTO dbo.promotion 				SELECT * FROM ' + @LakehouseName + '.dbo.promotion;
INSERT INTO dbo.reason 					SELECT * FROM ' + @LakehouseName + '.dbo.reason;
INSERT INTO dbo.sales 					SELECT * FROM ' + @LakehouseName + '.dbo.sales;
INSERT INTO dbo.ship_mode 				SELECT * FROM ' + @LakehouseName + '.dbo.ship_mode;
INSERT INTO dbo.store_returns 			SELECT * FROM ' + @LakehouseName + '.dbo.store_returns;
INSERT INTO dbo.store_sales 			SELECT * FROM ' + @LakehouseName + '.dbo.store_sales;
INSERT INTO dbo.time_dim 				SELECT * FROM ' + @LakehouseName + '.dbo.time_dim;
INSERT INTO dbo.warehouse 				SELECT * FROM ' + @LakehouseName + '.dbo.warehouse;
INSERT INTO dbo.web_page 				SELECT * FROM ' + @LakehouseName + '.dbo.web_page;
INSERT INTO dbo.web_returns 			SELECT * FROM ' + @LakehouseName + '.dbo.web_returns;
INSERT INTO dbo.web_sales 				SELECT * FROM ' + @LakehouseName + '.dbo.web_sales;
INSERT INTO dbo.web_site 				SELECT * FROM ' + @LakehouseName + '.dbo.web_site;
')

/*  Use this section to load the data warehouse from parquet files in ADLS Gen2.  */
DECLARE @StorageAccountName 		VARCHAR(250) = ''
DECLARE @StorageAccountDirectory 	VARCHAR(250) = ''
DECLARE @SharedAccessSignature		VARCHAR(250) = ''

EXEC ('
COPY INTO dbo.call_center 				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/call_center/*.parquet'' 				WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.catalog_page 				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/catalog_page/*.parquet'' 				WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.catalog_returns 			FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/catalog_returns/*.parquet'' 			WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.catalog_sales 			FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/catalog_sales/*.parquet'' 			WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.customer 					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/customer/*.parquet'' 					WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.customer_address 			FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/customer_address/*.parquet'' 			WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.customer_demographics 	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/customer_demographics/*.parquet'' 	WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.date_dim 					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/date_dim/*.parquet'' 					WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.household_demographics 	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/household_demographics/*.parquet'' 	WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.income_band 				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/income_band/*.parquet'' 				WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.inventory 				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/inventory/*.parquet'' 				WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.item 						FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/item/*.parquet'' 						WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.promotion 				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/promotion/*.parquet'' 				WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.reason 					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/reason/*.parquet'' 					WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.ship_mode 				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/ship_mode/*.parquet'' 				WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.store 					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/store/*.parquet'' 					WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.store_returns 			FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/store_returns/*.parquet'' 			WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.store_sales 				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/store_sales/*.parquet'' 				WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.time_dim 					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/time_dim/*.parquet'' 					WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.warehouse 				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/warehouse/*.parquet'' 				WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.web_page 					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/web_page/*.parquet'' 					WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.web_returns 				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/web_returns/*.parquet'' 				WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.web_sales 				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/web_sales/*.parquet'' 				WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.web_site 					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/web_site/*.parquet'' 					WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
')

/*  Use this section to load the data warehouse from the raw dat files in ADLS Gen2.  */
DECLARE @StorageAccountName 		VARCHAR(250) = ''
DECLARE @StorageAccountDirectory 	VARCHAR(250) = ''
DECLARE @SharedAccessSignature		VARCHAR(250) = ''

EXEC('
COPY INTO dbo.call_center				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/call_center/*.dat''				WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.catalog_page				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/catalog_page/*.dat''				WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.catalog_returns			FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/catalog_returns/*.dat''			WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.catalog_sales				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/catalog_sales/*.dat''				WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.customer					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/customer/*.dat''					WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.customer_address			FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/customer_address/*.dat''			WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.customer_demographics		FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/customer_demographics/*.dat''		WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.date_dim					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/date_dim/*.dat''					WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.dbgen_version				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/dbgen_version/*.dat''				WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.household_demographics	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/household_demographics/*.dat''	WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.income_band				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/income_band/*.dat''				WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.inventory					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/inventory/*.dat''					WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.item						FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/item/*.dat''						WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.promotion					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/promotion/*.dat''					WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.reason					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/reason/*.dat''					WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.ship_mode					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/ship_mode/*.dat''					WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.store						FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/store/*.dat''						WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.store_returns				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/store_returns/*.dat''				WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.store_sales				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/store_sales/*.dat''				WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.time_dim					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/time_dim/*.dat''					WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.warehouse					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/warehouse/*.dat''					WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.web_page					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/web_page/*.dat''					WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.web_returns				FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/web_returns/*.dat''				WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.web_sales					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/web_sales/*.dat''					WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.web_site					FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/web_site/*.dat''					WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
')