/*  Use this section to load the data warehouse from tables in the lakehouse.  */
DECLARE @LakehouseName VARCHAR(250) = ''

EXEC ('
INSERT INTO dbo.customer	SELECT * FROM ' + @LakehouseName + '.dbo.customer;
INSERT INTO dbo.lineitem	SELECT * FROM ' + @LakehouseName + '.dbo.lineitem;
INSERT INTO dbo.nation 		SELECT * FROM ' + @LakehouseName + '.dbo.nation;
INSERT INTO dbo.orders		SELECT * FROM ' + @LakehouseName + '.dbo.orders;
INSERT INTO dbo.part		SELECT * FROM ' + @LakehouseName + '.dbo.part;
INSERT INTO dbo.partsupp	SELECT * FROM ' + @LakehouseName + '.dbo.partsupp;
INSERT INTO dbo.region		SELECT * FROM ' + @LakehouseName + '.dbo.region;
INSERT INTO dbo.supplier	SELECT * FROM ' + @LakehouseName + '.dbo.supplier;
')

/*  Use this section to load the data warehouse from parquet files in ADLS Gen2.  */
DECLARE @StorageAccountName 		VARCHAR(250) = ''
DECLARE @StorageAccountDirectory 	VARCHAR(250) = ''
DECLARE @SharedAccessSignature		VARCHAR(250) = ''

EXEC ('
COPY INTO dbo.customer	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/customer/*.parquet''	WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.lineitem	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/lineitem/*.parquet''	WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.nation	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/nation/*.parquet''	WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.orders	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/orders/*.parquet''	WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.part		FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/part/*.parquet''		WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.partsupp	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/partsupp/*.parquet''	WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.region 	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/region/*.parquet'' 	WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.supplier	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/supplier/*.parquet''	WITH (FILE_TYPE = ''PARQUET'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
')

/*  Use this section to load the data warehouse from the raw tbl files in ADLS Gen2.  */
DECLARE @StorageAccountName 		VARCHAR(250) = ''
DECLARE @StorageAccountDirectory 	VARCHAR(250) = ''
DECLARE @SharedAccessSignature		VARCHAR(250) = ''

EXEC('
COPY INTO dbo.customer	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/customer/*.tbl*''		WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.lineitem	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/lineitem/*.tbl*''	    WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.nation	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/nation/*.tbl*''		WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.orders	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/orders/*.tbl*''		WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.part		FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/part/*.tbl*''			WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.partsupp	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/partsupp/*.tbl*''		WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.region 	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/region/*.tbl*'' 		WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
COPY INTO dbo.supplier	FROM ''https://' + @StorageAccountName + '.blob.core.windows.net/' + @StorageAccountDirectory + '/supplier/*.tbl*''		WITH (FILE_TYPE = ''CSV'', FIELDTERMINATOR = ''|'', CREDENTIAL = (IDENTITY = ''SHARED ACCESS SIGNATURE'', SECRET = ''' + @SharedAccessSignature + '''));
')