# qgen parameters.
$qgenDirectory              = "C:\GitHub\sample-data\TPC-H\Tools\qgen"  # Directory where qgen.exe, dists.dss, and the 22 sql template files are stored.
$OutputDirectory            = "C:\GitHub\sample-data\TPC-H"             # Directory where the generated queries will be stored.
$SeedValue                  = 081310311                                 # Seed value for the random number generator. According to the spec this values should be the time stamp of the end of the database load time expressed in the format mmddhhmmss where mm is the month, dd the day, hh the hour, mm the minutes and ss the seconds.
$GenerateAsStoredProcedure  = $false

# Which scale factors should be generated?
$GB_001 = $true
$GB_010 = $true
$GB_030 = $true
$GB_100 = $true
$GB_300 = $true
$TB_001 = $true
$TB_003 = $true
$TB_010 = $true
$TB_030 = $true
$TB_100 = $true

<#    !!! Only make changes below this line after reviewing and testing the modifications !!!    #>

# Change to the directory that contains qgen.
Set-Location $qgenDirectory

# Create the output directory if it does not exist.
if (!(Test-Path $OutputDirectory)) {
    New-Item -ItemType Directory -Path $OutputDirectory
}

# Store the full location of qgen.exe.
$qgen = Join-Path -Path $qgenDirectory -ChildPath "qgen.exe"

Clear-Host
function Invoke-qgen {
    param (
        [string]$OutputFile,
        [string]$DataSize,
        [int]$ScaleFactor,
        [string]$SeedValue,
        [boolean]$GenerateAsStoredProcedure
    )

    Write-Host ("Generating file {0}" -f $OutputFile)

    # Generate the queries and store the text in a variable.
    $Queries = & $qgen -r $SeedValue -c -s $ScaleFactor

    $FileList = @(
        @{Query = 1;        QueryName = "01";   StartLine = 7;      EndLine = 27},
        @{Query = 2;        QueryName = "02";   StartLine = 37;     EndLine = 79},
        @{Query = 3;        QueryName = "03";   StartLine = 89;     EndLine = 110},
        @{Query = 4;        QueryName = "04";   StartLine = 120;    EndLine = 140},
        @{Query = 5;        QueryName = "05";   StartLine = 150;    EndLine = 173},
        @{Query = 6;        QueryName = "06";   StartLine = 183;    EndLine = 191},
        @{Query = 7;        QueryName = "07";   StartLine = 201;    EndLine = 239},
        @{Query = 8;        QueryName = "08";   StartLine = 249;    EndLine = 285},
        @{Query = 9;        QueryName = "09";   StartLine = 295;    EndLine = 326},
        @{Query = 10;       QueryName = "10";   StartLine = 336;    EndLine = 366},
        @{Query = 11;       QueryName = "11";   StartLine = 376;    EndLine = 402},
        @{Query = 12;       QueryName = "12";   StartLine = 412;    EndLine = 439},
        @{Query = 13;       QueryName = "13";   StartLine = 449;    EndLine = 468},
        @{Query = 14;       QueryName = "14";   StartLine = 478;    EndLine = 490},
        @{Query = 15.1;     QueryName = "15";   StartLine = 499;    EndLine = 509},
        @{Query = 15.2;     QueryName = "15";   StartLine = 512;    EndLine = 530},
        @{Query = 15.3;     QueryName = "15";   StartLine = 532;    EndLine = 532}
        @{Query = 16;       QueryName = "16";   StartLine = 542;    EndLine = 571},
        @{Query = 17;       QueryName = "17";   StartLine = 581;    EndLine = 597},
        @{Query = 18;       QueryName = "18";   StartLine = 607;    EndLine = 638},
        @{Query = 19;       QueryName = "19";   StartLine = 648;    EndLine = 682},
        @{Query = 20;       QueryName = "20";   StartLine = 692;    EndLine = 728},
        @{Query = 21;       QueryName = "21";   StartLine = 738;    EndLine = 776},
        @{Query = 22;       QueryName = "22";   StartLine = 786;    EndLine = 822}
    )

    # Initiate the output file.
    "" | Out-File -FilePath $OutputFile

    if($GenerateAsStoredProcedure) {
        "DROP PROCEDURE IF EXISTS dbo.RunQuery" | Out-File -FilePath $OutputFile -Append
        "GO" | Out-File -FilePath $OutputFile -Append
        "" | Out-File -FilePath $OutputFile -Append
        "CREATE PROCEDURE dbo.RunQuery"  | Out-File -FilePath $OutputFile -Append
        "    @Query                  NVARCHAR(20)," | Out-File -FilePath $OutputFile -Append
        "    @Dataset                NVARCHAR(50)     = 'TPC-H'," | Out-File -FilePath $OutputFile -Append
        "    @DataSize               NVARCHAR(50)     = '{0}'," -f $DataSize | Out-File -FilePath $OutputFile -Append
        "    @Seed                   NVARCHAR(50)     = '{0}'," -f $SeedValue | Out-File -FilePath $OutputFile -Append
        "    @AdditionalInformation  NVARCHAR(MAX)    = NULL," | Out-File -FilePath $OutputFile -Append
        "    @QueryLog               NVARCHAR(MAX)    OUTPUT" | Out-File -FilePath $OutputFile -Append
        "AS" | Out-File -FilePath $OutputFile -Append
        "BEGIN" | Out-File -FilePath $OutputFile -Append
        "" | Out-File -FilePath $OutputFile -Append
    }
        
    "    /*************************************   Notes   *************************************/" | Out-File -FilePath $OutputFile -Append
    "    /*" | Out-File -FilePath $OutputFile -Append
    "        Generated on {0}" -f (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd") | Out-File -FilePath $OutputFile -Append
    "        This is the TPC-H {0} GB ({1}) scale factor queries modified for Fabric DW T-SQL syntax." -f $ScaleFactor, $DataSize | Out-File -FilePath $OutputFile -Append
    "" | Out-File -FilePath $OutputFile -Append 
    "        TPC-H Parameter Substitution (Version 3.0.0 build 0)" | Out-File -FilePath $OutputFile -Append
    "        Using {0} as a seed to the RNG" -f $SeedValue | Out-File -FilePath $OutputFile -Append
    "    */" | Out-File -FilePath $OutputFile -Append
    "" | Out-File -FilePath $OutputFile -Append
    "" | Out-File -FilePath $OutputFile -Append

    if($GenerateAsStoredProcedure) {
        "    /*************************************   Variables   *************************************/" | Out-File -FilePath $OutputFile -Append
        "    /* Create the variables for runtime. */" | Out-File -FilePath $OutputFile -Append
        "    DECLARE @QueryStartTime    DATETIME2(6)" | Out-File -FilePath $OutputFile -Append
        "    DECLARE @QueryEndTime      DATETIME2(6)" | Out-File -FilePath $OutputFile -Append
        "    DECLARE @SessionID         INT" | Out-File -FilePath $OutputFile -Append
        "" | Out-File -FilePath $OutputFile -Append
        "" | Out-File -FilePath $OutputFile -Append
        "    /*************************************   Query Start   *************************************/" | Out-File -FilePath $OutputFile -Append
        "" | Out-File -FilePath $OutputFile -Append
        "    SET @SessionID         = @@SPID" | Out-File -FilePath $OutputFile -Append
        "    SET @QueryStartTime    = GETDATE()" | Out-File -FilePath $OutputFile -Append
        "" | Out-File -FilePath $OutputFile -Append
        "" | Out-File -FilePath $OutputFile -Append
    }
    

    # Loop over the queries, generate the file, cleanup, and write the text to the final output file.
    foreach ($File in $FileList) {
        $Query          = $File.Query
        $QueryName      = $File.QueryName
        $StartLine      = if ($Query -in (15.1, 15.2, 15.3)) {$File.StartLine} else {$File.StartLine + 1}
        $EndLine        = $File.EndLine
        $RowCountLine   = $File.EndLine + 1
    
        if($Query -notin (15.2, 15.3)) {"    /*************************************   TPCH Query {0}   *************************************/" -f $QueryName | Out-File -FilePath $OutputFile -Append}
        if($Query -notin (15.2, 15.3)) {"" | Out-File -FilePath $OutputFile -Append}
        
        if($GenerateAsStoredProcedure -and $Query -notin (15.2, 15.3)) {
            ("    IF @Query = 'TPC-H Query {0}'" -f $QueryName) | Out-File -FilePath $OutputFile -Append
        }

        if($GenerateAsStoredProcedure -and $Query -eq 15.1) {
            ("    BEGIN") | Out-File -FilePath $OutputFile -Append
        }
        
        # Handle TOP N syntax.
        if ($Query -notin (15.1, 15.2, 15.3)) {
            $Pattern = "set rowcount (?<RowCount>.+)"
            $PatternMatches = ($Queries[$RowCountLine] | Select-String -Pattern $Pattern).Matches
            if ($PatternMatches) {
                if ($PatternMatches[0].Groups['RowCount'].value -ne "-1") {"        select top {0}" -f $PatternMatches[0].Groups['RowCount'].value | Out-File -FilePath $OutputFile -Append}
                else {'        select' | Out-File -FilePath $OutputFile -Append}
            }
        }

        $CurrentLine = $StartLine
    
        foreach($Line in $Queries[$StartLine..($EndLine)]) {
            # Handle date functions.
            if ($Line -like "*interval*") {
                # Handle dateadd syntax.
                $Pattern = "(?<BeforeCast>.+)date (?<Date>'.{1,10}').+(?<IntervalOperation>[+-]).+interval.+'(?<Interval>\d+)'\s+(?<IntervalType>\w+)"
                $PatternMatches = ($Line | Select-String -Pattern $Pattern).Matches
                if ($PatternMatches) {
                    $Line = "{0} dateadd({1}, {2}{3}, {4}) /*  {5}  */" -f $PatternMatches[0].Groups['BeforeCast'].Value, $PatternMatches[0].Groups['IntervalType'].Value, $PatternMatches[0].Groups['IntervalOperation'].Value, $PatternMatches[0].Groups['Interval'].Value, $PatternMatches[0].Groups['Date'].Value, $Line.Trim()
                }
            }
            elseif ($Line -like "*between date* and date*") {
                $Pattern = "(?<BeforeCast>.+between )date (?<FirstDate>'.{1,10}') and date (?<SecondDate>'.{1,10}').*"
                $PatternMatches = ($Line | Select-String -Pattern $Pattern).Matches
                if ($PatternMatches) {
                    $Line = "{0} {1} and {2} /*  {3}  */" -f $PatternMatches[0].Groups['BeforeCast'].Value, $PatternMatches[0].Groups['FirstDate'].Value, $PatternMatches[0].Groups['SecondDate'].Value, $Line.Trim()
                }
            }
            elseif ($Line -like "* date '*") {
                $Pattern = "(?<BeforeCast>.+ )date (?<Date>'.{1,10}').*"
                $PatternMatches = ($Line | Select-String -Pattern $Pattern).Matches
                if ($PatternMatches) {
                    $Line = "{0} {1} /*  {2}  */" -f $PatternMatches[0].Groups['BeforeCast'].Value, $PatternMatches[0].Groups['Date'].Value, $Line.Trim()
                }
            }
    
            # Query specific handling.
            if ($QueryName -eq "07" -and $CurrentLine -eq 211)   {$Line = "{1} /* {0} */" -f $Line.Trim(), ("datepart(year, l_shipdate) as l_year,")}
            if ($QueryName -eq "08" -and $CurrentLine -eq 258)   {$Line = "{1} /* {0} */" -f $Line.Trim(), ("datepart(year, o_orderdate) as o_year,")}
            if ($QueryName -eq "09" -and $CurrentLine -eq 303)   {$Line = "{1} /* {0} */" -f $Line.Trim(), ("datepart(year, o_orderdate) as o_year,")}
            if ($QueryName -eq "22" -and $CurrentLine -eq 793)   {$Line = "{1} /* {0} */" -f $Line.Trim(), ("substring(c_phone, 1, 2) as cntrycode,")}
            if ($QueryName -eq "22" -and $CurrentLine -eq 798)   {$Line = "{1} /* {0} */" -f $Line.Trim(), ("substring(c_phone, 1, 2) in")}
            if ($QueryName -eq "22" -and $CurrentLine -eq 807)   {$Line = "{1} /* {0} */" -f $Line.Trim(), ("and substring(c_phone, 1, 2) in")}
    
            # If this is the last line of the query remove the semicolon so we can add OPTION (LABEL) to the query.
            if($CurrentLine -eq $EndLine) {
                $Line = $Line.Replace(";", "")
            }
            
            # Handle query 15 create view statement.
            if ($query -eq 15.1) {
                if ($Line -like "*create view*") {
                    $Pattern = ".*create view (?<ViewName>.+) \(supplier.+"
                    $PatternMatches = ($Line | Select-String -Pattern $Pattern).Matches
                    if ($PatternMatches) {
                        $Line = "drop view if exists {0} /*  New line added for error handling.  */`r`n        EXEC ('{1}" -f $PatternMatches[0].Groups['ViewName'].Value, $Line
                    }
                }
                else {
                    $Line = $Line.Replace("'", "''")
                }

                # Handle the last line of the view.
                if($CurrentLine -eq $EndLine) {$Line = "    l_suppkey')"}
            }

            # Handle query 15 drop view statement.
            if ($Query -eq 15.3) {
                $Pattern = ".*drop view (?<ViewName>.+)"
                $PatternMatches = ($Line | Select-String -Pattern $Pattern).Matches
                if ($PatternMatches) {
                    $Line = "drop view if exists {0} /*  {1}  */" -f $PatternMatches[0].Groups['ViewName'].Value, $Line
                }
            }
            
            "        {0}" -f $Line | Out-File -FilePath $OutputFile -Append
    
            $CurrentLine ++
        }
    
        # Add  OPTION (LABEL) to close out the query.
        if($Query -notin (15.1, 15.3)){
            "        option (label = 'TPC-H Query {0}');" -f $QueryName | Out-File -FilePath $OutputFile -Append
        }

        if($GenerateAsStoredProcedure -and $Query -eq 15.3) {
            ("    END") | Out-File -FilePath $OutputFile -Append
        }

        "" | Out-File -FilePath $OutputFile -Append
        "" | Out-File -FilePath $OutputFile -Append
    }
    
    if($GenerateAsStoredProcedure) {
        "    /*************************************   Query End   *************************************/" | Out-File -FilePath $OutputFile -Append
        "" | Out-File -FilePath $OutputFile -Append
        "    SET @QueryEndTime = GETDATE()" | Out-File -FilePath $OutputFile -Append
        "" | Out-File -FilePath $OutputFile -Append
        "    SET @QueryLog = (SELECT @Dataset AS Dataset, @DataSize AS Datasize, @Seed AS Seed, @AdditionalInformation AS AdditionalInformation, @SessionID AS SessionID, @Query AS Query, @QueryStartTime AS QueryStartTime, @QueryEndTime AS QueryEndTime FOR JSON PATH)" | Out-File -FilePath $OutputFile -Append
        "END" | Out-File -FilePath $OutputFile -Append
        "GO" | Out-File -FilePath $OutputFile -Append
        "" | Out-File -FilePath $OutputFile -Append
        "" | Out-File -FilePath $OutputFile -Append
    }

    # Create the additional procedures that will loop over and call the query procedure.
    if($GenerateAsStoredProcedure) {"
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
        " | Out-File -FilePath $OutputFile -Append
    }
}

if ($GB_001) {Invoke-qgen -OutputFile (Join-Path -Path $OutputDirectory -ChildPath ("TPC-H - Queries {0}GB_001.sql" -f $(if($GenerateAsStoredProcedure) {"- Stored Procedure - "}))) -DataSize "GB_001" -ScaleFactor 1         -SeedValue $SeedValue -GenerateAsStoredProcedure $GenerateAsStoredProcedure}
if ($GB_010) {Invoke-qgen -OutputFile (Join-Path -Path $OutputDirectory -ChildPath ("TPC-H - Queries {0}GB_010.sql" -f $(if($GenerateAsStoredProcedure) {"- Stored Procedure - "}))) -DataSize "GB_010" -ScaleFactor 10        -SeedValue $SeedValue -GenerateAsStoredProcedure $GenerateAsStoredProcedure}
if ($GB_030) {Invoke-qgen -OutputFile (Join-Path -Path $OutputDirectory -ChildPath ("TPC-H - Queries {0}GB_030.sql" -f $(if($GenerateAsStoredProcedure) {"- Stored Procedure - "}))) -DataSize "GB_030" -ScaleFactor 30        -SeedValue $SeedValue -GenerateAsStoredProcedure $GenerateAsStoredProcedure}
if ($GB_100) {Invoke-qgen -OutputFile (Join-Path -Path $OutputDirectory -ChildPath ("TPC-H - Queries {0}GB_100.sql" -f $(if($GenerateAsStoredProcedure) {"- Stored Procedure - "}))) -DataSize "GB_100" -ScaleFactor 100       -SeedValue $SeedValue -GenerateAsStoredProcedure $GenerateAsStoredProcedure}
if ($GB_300) {Invoke-qgen -OutputFile (Join-Path -Path $OutputDirectory -ChildPath ("TPC-H - Queries {0}GB_300.sql" -f $(if($GenerateAsStoredProcedure) {"- Stored Procedure - "}))) -DataSize "GB_300" -ScaleFactor 300       -SeedValue $SeedValue -GenerateAsStoredProcedure $GenerateAsStoredProcedure}
if ($TB_001) {Invoke-qgen -OutputFile (Join-Path -Path $OutputDirectory -ChildPath ("TPC-H - Queries {0}TB_001.sql" -f $(if($GenerateAsStoredProcedure) {"- Stored Procedure - "}))) -DataSize "TB_001" -ScaleFactor 1000      -SeedValue $SeedValue -GenerateAsStoredProcedure $GenerateAsStoredProcedure}
if ($TB_003) {Invoke-qgen -OutputFile (Join-Path -Path $OutputDirectory -ChildPath ("TPC-H - Queries {0}TB_003.sql" -f $(if($GenerateAsStoredProcedure) {"- Stored Procedure - "}))) -DataSize "TB_003" -ScaleFactor 3000      -SeedValue $SeedValue -GenerateAsStoredProcedure $GenerateAsStoredProcedure}
if ($TB_010) {Invoke-qgen -OutputFile (Join-Path -Path $OutputDirectory -ChildPath ("TPC-H - Queries {0}TB_010.sql" -f $(if($GenerateAsStoredProcedure) {"- Stored Procedure - "}))) -DataSize "TB_010" -ScaleFactor 10000     -SeedValue $SeedValue -GenerateAsStoredProcedure $GenerateAsStoredProcedure}
if ($TB_030) {Invoke-qgen -OutputFile (Join-Path -Path $OutputDirectory -ChildPath ("TPC-H - Queries {0}TB_030.sql" -f $(if($GenerateAsStoredProcedure) {"- Stored Procedure - "}))) -DataSize "TB_030" -ScaleFactor 30000     -SeedValue $SeedValue -GenerateAsStoredProcedure $GenerateAsStoredProcedure}
if ($TB_100) {Invoke-qgen -OutputFile (Join-Path -Path $OutputDirectory -ChildPath ("TPC-H - Queries {0}TB_100.sql" -f $(if($GenerateAsStoredProcedure) {"- Stored Procedure - "}))) -DataSize "TB_100" -ScaleFactor 100000    -SeedValue $SeedValue -GenerateAsStoredProcedure $GenerateAsStoredProcedure}