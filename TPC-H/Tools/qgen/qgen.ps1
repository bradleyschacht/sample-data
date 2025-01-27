# qgen parameters.
$qgenDirectory              = "C:\GitHub\sample-data\TPC-H\Tools\qgen"  # Directory where qgen.exe, dists.dss, and the 22 sql template files are stored.
$OutputDirectory            = "C:\GitHub\sample-data\TPC-H\Queries"     # Directory where the generated queries will be stored.
$SeedValue                  = 081310311                                 # Seed value for the random number generator. According to the spec this values should be the time stamp of the end of the database load time expressed in the format mmddhhmmss where mm is the month, dd the day, hh the hour, mm the minutes and ss the seconds.
$GenerateOneFilePerQuery    = $false

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

# Store the full location of qgen.exe.
$qgen = Join-Path -Path $qgenDirectory -ChildPath "qgen.exe"

Clear-Host
function Invoke-qgen {
    param (
        [string]$OutputDirectory,
        [string]$DataSize,
        [int]$ScaleFactor,
        [string]$SeedValue,
        [boolean]$GenerateOneFilePerQuery
    )

    # Create the output directory if it does not exist.
    $OutputDirectory = Join-Path -Path $OutputDirectory -ChildPath ("{0} - {1}" -f $DataSize, $SeedValue)
    if (!(Test-Path $OutputDirectory)) {
        $null = New-Item -ItemType Directory -Path $OutputDirectory
    }

    Write-Host ("Generating files in {0}" -f $OutputDirectory)
    switch ($GenerateOneFilePerQuery) {
        $true {Write-Host "Generating one file per query."}
        $false {Write-Host "Generating one file containing all queries."}
    }

    # Generate the queries and store the text in a variable.
    $Queries = & $qgen -r $SeedValue -c -s $ScaleFactor

    $FileList = @(
        @{Query = 1;        QueryName = "01";   StartLine = 7;      EndLine = 27},
        @{Query = 2;        QueryName = "02";   StartLine = 37;     EndLine = 79}
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

    $FileHeader = 
        "/*************************************   Notes   *************************************/`r`n" + 
        "/*`r`n" + 
        "    Generated on {0}`r`n" -f (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd") + 
        "    This is the TPC-H {0} GB ({1}) scale factor queries modified for Fabric DW T-SQL syntax.`r`n" -f $ScaleFactor, $DataSize + 
        "`r`n" + 
        "    TPC-H Parameter Substitution (Version 3.0.0 build 0)`r`n" + 
        "    Using {0} as a seed to the RNG`r`n" -f $SeedValue + 
        "*/`r`n" + 
        "`r`n" + 
        "`r`n"

    if($false -eq $GenerateOneFilePerQuery) {
        $OutputFile = Join-Path -Path $OutputDirectory -ChildPath ("Queries.sql")

        # Initiate the output file.
        $FileHeader | Out-File -FilePath $OutputFile
    }
    
    # Loop over the queries, generate the file(s), cleanup, and write the text to the final output file.
    foreach ($File in $FileList) {
        $Query          = $File.Query
        $QueryName      = $File.QueryName
        $StartLine      = if ($Query -in (15.1, 15.2, 15.3)) {$File.StartLine} else {$File.StartLine + 1}
        $EndLine        = $File.EndLine
        $RowCountLine   = $File.EndLine + 1
    
        if($true -eq $GenerateOneFilePerQuery -and $File.Query -notin (15.2, 15.3)) {
            $OutputFile = Join-Path -Path $OutputDirectory -ChildPath ("Query {0}.sql" -f $File.QueryName)
            $FileHeader | Out-File -FilePath $OutputFile
        }
        
        if($Query -notin (15.2, 15.3)) {"    /*************************************   TPC-H Query {0}   *************************************/" -f $QueryName | Out-File -FilePath $OutputFile -Append}
        if($Query -notin (15.2, 15.3)) {"" | Out-File -FilePath $OutputFile -Append}
        
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
            if ($QueryName -eq "01" -and $CurrentLine -eq 17)    {$Line = "{1} /* {0} */" -f $Line.Trim(), ("count_big(*) as count_order")}
            if ($QueryName -eq "04" -and $CurrentLine -eq 122)   {$Line = "{1} /* {0} */" -f $Line.Trim(), ("count_big(*) as order_count")}
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
                        $Line = "IF NOT EXISTS(SELECT * FROM sys.views WHERE name = '{0}') /*  New line added for error handling.  */`r`n        EXEC ('{1}" -f $PatternMatches[0].Groups['ViewName'].Value, $Line
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
                    $Line = "/*  {0}  */" -f $Line
                }
            }
            
            "        {0}" -f $Line | Out-File -FilePath $OutputFile -Append
    
            $CurrentLine ++
        }
    
        # Add  OPTION (LABEL) to close out the query.
        if($Query -notin (15.1, 15.3)){
            "        option (label = 'TPC-H Query {0}');" -f $QueryName | Out-File -FilePath $OutputFile -Append
        }

        "" | Out-File -FilePath $OutputFile -Append
        "" | Out-File -FilePath $OutputFile -Append
    }
}

if ($GB_001) {Invoke-qgen -OutputDirectory $OutputDirectory -DataSize "GB_001" -ScaleFactor 1         -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}
if ($GB_010) {Invoke-qgen -OutputDirectory $OutputDirectory -DataSize "GB_010" -ScaleFactor 10        -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}
if ($GB_030) {Invoke-qgen -OutputDirectory $OutputDirectory -DataSize "GB_030" -ScaleFactor 30        -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}
if ($GB_100) {Invoke-qgen -OutputDirectory $OutputDirectory -DataSize "GB_100" -ScaleFactor 100       -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}
if ($GB_300) {Invoke-qgen -OutputDirectory $OutputDirectory -DataSize "GB_300" -ScaleFactor 300       -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}
if ($TB_001) {Invoke-qgen -OutputDirectory $OutputDirectory -DataSize "TB_001" -ScaleFactor 1000      -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}
if ($TB_003) {Invoke-qgen -OutputDirectory $OutputDirectory -DataSize "TB_003" -ScaleFactor 3000      -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}
if ($TB_010) {Invoke-qgen -OutputDirectory $OutputDirectory -DataSize "TB_010" -ScaleFactor 10000     -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}
if ($TB_030) {Invoke-qgen -OutputDirectory $OutputDirectory -DataSize "TB_030" -ScaleFactor 30000     -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}
if ($TB_100) {Invoke-qgen -OutputDirectory $OutputDirectory -DataSize "TB_100" -ScaleFactor 100000    -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}