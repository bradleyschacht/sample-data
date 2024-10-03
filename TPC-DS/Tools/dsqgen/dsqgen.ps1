# qgen parameters.
$dsqgenDirectory            = "C:\GitHub\sample-data\TPC-DS\Tools\dsqgen"   # Directory where dsqgen.exe, tpcds.idx, and the template files are stored.
$OutputDirectory            = "C:\GitHub\sample-data\TPC-DS\Queries"                # Directory where the generated queries will be stored.
$SeedValue                  = 081310311                                     # Seed value for the random number generator. According to the spec this values should be the time stamp of the end of the database load time expressed in the format mmddhhmmss where mm is the month, dd the day, hh the hour, mm the minutes and ss the seconds.
$GenerateOneFilePerQuery    = $true

# Which scale factors should be generated?
$GB_001 = $true
$TB_001 = $true
$TB_003 = $true
$TB_010 = $true
$TB_030 = $true
$TB_100 = $true

<#    !!! Only make changes below this line after reviewing and testing the modifications !!!    #>

# Change to the directory that contains qgen.
Set-Location $dsqgenDirectory

# Store the full location of qgen.exe.
$dsqgen = Join-Path -Path $dsqgenDirectory -ChildPath "dsqgen.exe"

clear-host
function Invoke-dsqgen {
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

    # Generate a hashtable with all the queries that need to be generated.
    $QueryList = [ordered]@{
        "01" = "query1.tpl"
        "02" = "query2.tpl"
        "03" = "query3.tpl"
        "04" = "query4.tpl"
        "05" = "query5.tpl"
        "06" = "query6.tpl"
        "07" = "query7.tpl"
        "08" = "query8.tpl"
        "09" = "query9.tpl"
        "10" = "query10.tpl"
        "11" = "query11.tpl"
        "12" = "query12.tpl"
        "13" = "query13.tpl"
        "14" = "query14.tpl"
        "15" = "query15.tpl"
        "16" = "query16.tpl"
        "17" = "query17.tpl"
        "18" = "query18.tpl"
        "19" = "query19.tpl"
        "20" = "query20.tpl"
        "21" = "query21.tpl"
        "22" = "query22.tpl"
        "23" = "query23.tpl"
        "24" = "query24.tpl"
        "25" = "query25.tpl"
        "26" = "query26.tpl"
        "27" = "query27.tpl"
        "28" = "query28.tpl"
        "29" = "query29.tpl"
        "30" = "query30.tpl"
        "31" = "query31.tpl"
        "32" = "query32.tpl"
        "33" = "query33.tpl"
        "34" = "query34.tpl"
        "35" = "query35.tpl"
        "36" = "query36.tpl"
        "37" = "query37.tpl"
        "38" = "query38.tpl"
        "39" = "query39.tpl"
        "40" = "query40.tpl"
        "41" = "query41.tpl"
        "42" = "query42.tpl"
        "43" = "query43.tpl"
        "44" = "query44.tpl"
        "45" = "query45.tpl"
        "46" = "query46.tpl"
        "47" = "query47.tpl"
        "48" = "query48.tpl"
        "49" = "query49.tpl"
        "50" = "query50.tpl"
        "51" = "query51.tpl"
        "52" = "query52.tpl"
        "53" = "query53.tpl"
        "54" = "query54.tpl"
        "55" = "query55.tpl"
        "56" = "query56.tpl"
        "57" = "query57.tpl"
        "58" = "query58.tpl"
        "59" = "query59.tpl"
        "60" = "query60.tpl"
        "61" = "query61.tpl"
        "62" = "query62.tpl"
        "63" = "query63.tpl"
        "64" = "query64.tpl"
        "65" = "query65.tpl"
        "66" = "query66.tpl"
        "67" = "query67.tpl"
        "68" = "query68.tpl"
        "69" = "query69.tpl"
        "70" = "query70.tpl"
        "71" = "query71.tpl"
        "72" = "query72.tpl"
        "73" = "query73.tpl"
        "74" = "query74.tpl"
        "75" = "query75.tpl"
        "76" = "query76.tpl"
        "77" = "query77.tpl"
        "78" = "query78.tpl"
        "79" = "query79.tpl"
        "80" = "query80.tpl"
        "81" = "query81.tpl"
        "82" = "query82.tpl"
        "83" = "query83.tpl"
        "84" = "query84.tpl"
        "85" = "query85.tpl"
        "86" = "query86.tpl"
        "87" = "query87.tpl"
        "88" = "query88.tpl"
        "89" = "query89.tpl"
        "90" = "query90.tpl"
        "91" = "query91.tpl"
        "92" = "query92.tpl"
        "93" = "query93.tpl"
        "94" = "query94.tpl"
        "95" = "query95.tpl"
        "96" = "query96.tpl"
        "97" = "query97.tpl"
        "98" = "query98.tpl"
        "99" = "query99.tpl"
    }

    $FileHeader = 
        "/*************************************   Notes   *************************************/`r`n" + 
        "/*`r`n" + 
        "    Generated on {0}`r`n" -f (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd") + 
        "    This is the TPC-DS {0} GB ({1}) scale factor queries modified for Fabric DW T-SQL syntax.`r`n" -f $ScaleFactor, $DataSize + 
        "`r`n" + 
        "    TPC-DS Parameter Substitution (Version 3.2.0)`r`n" + 
        "    Using {0} as a seed to the RNG`r`n" -f $SeedValue + 
        "*/`r`n" + 
        "`r`n" + 
        "`r`n"
       
    if($false -eq $GenerateOneFilePerQuery) {
        $OutputFile = Join-Path -Path $OutputDirectory -ChildPath ("Queries.sql")

        # Initiate the output file.
        $FileHeader | Out-File -FilePath $OutputFile
    }

    # Loop over the queries, generate the file, cleanup, and write the text to the final output file.
    foreach ($Query in $QueryList.GetEnumerator()) {
        do {
            # Generate the query.
            & $dsqgen -directory . -input templates.lst -dialect sqlserver -scale $ScaleFactor -output_dir . -template $Query.Value -RNGSEED $SeedValue > $null 2>&1

            # Read the file.
            $File = (Get-Content -Path "query_0.sql")

            # If the file is empty, remove it.
            if($File.Count -eq 0) {
                # Write-Host  "Failure generating query."
                Remove-Item -Path "query_0.sql"
            }
        } while (
            # If the file does not contain any text, then regenerate the file again.
            $File.Count -eq 0
        )

        # Remove the blank lines from the query.
        $FileContent = @()
        foreach ($Line in $File) {
            if ($Line.trim() -ne "") {
                $FileContent += $Line#.ToLower()
            }
        }

        if($true -eq $GenerateOneFilePerQuery -and $File.Query -notin (15.2, 15.3)) {
            $OutputFile = Join-Path -Path $OutputDirectory -ChildPath ("Query {0}.sql" -f $Query.Name)
            $FileHeader | Out-File -FilePath $OutputFile
        }

        ("    /*************************************   TPC-DS Query {0}   *************************************/" -f $Query.Name) | Out-File -FilePath $OutputFile -Append
        "" | Out-File -FilePath $OutputFile -Append

        # Append the query to the output file.
        $LineCount = 1
        foreach ($Line in $FileContent) {
            # Handle a CTE as the first item in a query.
            if($Line.Trim() -like "with*" -and $LineCount -eq 1) {
                $Line = ";{0}" -f $Line.Trim()
            }
            
            # Handle syntax differences for SQL Server.            
            # Handle substring syntax.
            if($Line -like "*substr(*") {$Line = "{1} /* {0} */" -f $Line.Trim(), ($Line.Trim().Replace("substr(", "substring("))}

            # Handle standard deviation syntax.
            if($Line -like "*stddev_samp(*") {$Line = "{1} /* {0} */" -f $Line.Trim(), ($Line.Trim().Replace("stddev_samp(", "stdev("))}

            # Handle dateadd syntax.
            $Pattern = "(?<BeforeCast>.+)(?<DateCast>cast\s*\('(?<Date>\d+-\d+-\d+)'\s*as\s*date\)\s*(?<Days>[\+-]\s*\d+)\s*days)(?<AfterCast>.+)" # $Pattern = "(?<BeforeCast>.+)(?<DateCast>cast\('(?<Date>\d+-\d+-\d+)' as date\)\s+\+\s+(?<Days>\d+) days)(?<AfterCast>.+)"
            $PatternMatches = ($Line | Select-String -Pattern $Pattern).Matches
            if ($PatternMatches) {
                $Line = "{3}dateadd(day, {0}, cast('{1}' as date)){4} /*  {2}  */" -f $PatternMatches[0].Groups['Days'].value, $PatternMatches[0].Groups['Date'].value, $Line.Trim(), $PatternMatches[0].Groups['BeforeCast'].value, $PatternMatches[0].Groups['AfterCast'].value   
            }

            # Handle concatenation syntax.
            if ($Line -like "*||*||*") {
                $Pattern = "(?<Before>.+)\|\|(?<Between>.+)\|\|(?<After>.+)"
                $PatternMatches = ($Line | Select-String -Pattern $Pattern).Matches
                if ($PatternMatches) {    
                    $Line = "{1} + {2} + {3} /*  {0}  */" -f $Line.Trim(), $PatternMatches[0].Groups['Before'].value, $PatternMatches[0].Groups['Between'].value, $PatternMatches[0].Groups['After'].value
                }
            }
            elseif ($Line -like "*||*") {
                $Pattern = "(?<Before>.+)\|\|(?<After>.+)"
                $PatternMatches = ($Line | Select-String -Pattern $Pattern).Matches
                if ($PatternMatches) {
                    $Line = "{1} + {2} /*  {0}  */" -f $Line.Trim(), $PatternMatches[0].Groups['Before'].value, $PatternMatches[0].Groups['After'].value
                }
            }

            # Query specific handling.
            if ($Query.Name -eq "01" -and $LineCount -eq 4)   {$Line = $Line.ToLower()}
            if ($Query.Name -eq "02" -and $LineCount -eq 10)  {$Line = "{1} /* {0} */" -f $Line.Trim(), ("from catalog_sales) AS x),")}
            if ($Query.Name -eq "05" -and $LineCount -eq 102) {$Line = "{1} /* {0} */" -f $Line.Trim(), (", 'store' + s_store_id as id")}
            if ($Query.Name -eq "05" -and $LineCount -eq 109) {$Line = "{1} /* {0} */" -f $Line.Trim(), (", 'catalog_page' + cp_catalog_page_id as id")}
            if ($Query.Name -eq "05" -and $LineCount -eq 116) {$Line = "{1} /* {0} */" -f $Line.Trim(), (", 'web_site' + web_site_id as id")}
            if ($Query.Name -eq "06" -and $LineCount -eq 1)   {$Line = "{1} /* {0} */" -f $Line.Trim(), ($Line.Trim().Replace("count", "count_big"))}
            if ($Query.Name -eq "14" -and $LineCount -eq 32)  {$Line = "{1} /* {0} */" -f $Line.Trim(), ("{0} AS x" -f $Line.Trim())}
            if ($Query.Name -eq "23" -and $LineCount -eq 20)  {$Line = "{1} /* {0} */" -f $Line.Trim(), ("group by c_customer_sk) AS x),")}
            if ($Query.Name -eq "23" -and $LineCount -eq 48)  {$Line = "{1} /* {0} */" -f $Line.Trim(), ("and ws_bill_customer_sk in (select c_customer_sk from best_ss_customer)) AS x")}
            if ($Query.Name -eq "23" -and $LineCount -eq 69)  {$Line = "{1} /* {0} */" -f $Line.Trim(), ("group by c_customer_sk) AS x),")}
            if ($Query.Name -eq "23" -and $LineCount -eq 102) {$Line = "{1} /* {0} */" -f $Line.Trim(), ("group by c_last_name,c_first_name) AS x")}
            if ($Query.Name -eq "36" -and $LineCount -eq 25)  {$Line = "{1} /* {0} */" -f $Line.Trim(), (",case when grouping(i_category)+grouping(i_class) = 0 then i_category end" -f $Line.Trim())}
            if ($Query.Name -eq "41" -and $LineCount -eq 1)   {$Line = "{1} /* {0} */" -f $Line.Trim(), ("select distinct top 100 (i_product_name)")}
            if ($Query.Name -eq "49" -and $LineCount -eq 124) {$Line = "{1} /* {0} */" -f $Line.Trim(), (") AS x")}
            if ($Query.Name -eq "70" -and $LineCount -eq 33)  {$Line = "{1} /* {0} */" -f $Line.Trim(), (",case when grouping(s_state)+grouping(s_county) = 0 then s_state end" -f $Line.Trim())}
            if ($Query.Name -eq "72" -and $LineCount -eq 20)  {$Line = "{1} /* {0} */" -f $Line.Trim(), ("and d3.d_date > dateadd(day, 5, d1.d_date)" -f $Line.Trim())}
            if ($Query.Name -eq "86" -and $LineCount -eq 21)  {$Line = "{1} /* {0} */" -f $Line.Trim(), ("case when grouping(i_category)+grouping(i_class) = 0 then i_category end," -f $Line.Trim())}

            # If this is the last line of the file, add the OPTION (LABEL) to the query.
            if ($LineCount -eq $FileContent.Count) {
                if ($Line.trim() -eq ";") {
                    ("        OPTION (LABEL = 'TPC-DS Query {0}');" -f $Query.Name) |  Out-File -FilePath $OutputFile -Append
                }
                else {
                    $Line.replace(";", "") |  Out-File -FilePath $OutputFile -Append
                    ("        OPTION (LABEL = 'TPC-DS Query {0}');" -f $Query.Name) |  Out-File -FilePath $OutputFile -Append
                }
            }
            # If it is not the last line of the file, then just write the line to the output file. 
            else {
                ("        " + $Line) |  Out-File -FilePath $OutputFile -Append
            }
    
            $LineCount ++
        }

        # Add two empty lines before the next query.
        "" | Out-File -FilePath $OutputFile -Append
        "" | Out-File -FilePath $OutputFile -Append
    }

    # Remove the query_0 file when the process is complete. 
    Remove-Item -Path "query_0.sql"
}

if ($GB_001) {Invoke-dsqgen -OutputDirectory $OutputDirectory -DataSize "GB_001" -ScaleFactor 1      -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}
if ($TB_001) {Invoke-dsqgen -OutputDirectory $OutputDirectory -DataSize "TB_001" -ScaleFactor 1000   -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}
if ($TB_003) {Invoke-dsqgen -OutputDirectory $OutputDirectory -DataSize "TB_003" -ScaleFactor 3000   -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}
if ($TB_010) {Invoke-dsqgen -OutputDirectory $OutputDirectory -DataSize "TB_010" -ScaleFactor 10000  -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}
if ($TB_030) {Invoke-dsqgen -OutputDirectory $OutputDirectory -DataSize "TB_030" -ScaleFactor 30000  -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}
if ($TB_100) {Invoke-dsqgen -OutputDirectory $OutputDirectory -DataSize "TB_100" -ScaleFactor 100000 -SeedValue $SeedValue -GenerateOneFilePerQuery $GenerateOneFilePerQuery}