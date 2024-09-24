# dsdgen parameters.
$dsdgenDirectory = "C:\TPCDS\dsdgen"   # Directory where dsdgen.exe and tpcds.idx are stored. 
$OutputDirectory = "C:\TPCDS\GB_001"   # Directory where the files will be generated and temporarily stored before being moved to the appropriate table specific subdirectory inside this directory.
$ScaleFactor     = 1   # Measured in GB.
$ParallelJobs    = 1   # Number of parallel data generation jobs.


# Which tables should be generated?
$CallCenter               = $true
$CatalogPage              = $true
$CatalogSales             = $true  # Catalog returns is generated as part of catalog sales.
$Customer                 = $true
$CustomerAddress          = $true
$CustomerDemographics     = $true
$DateDim                  = $true
$dbgenVersion             = $true
$HouseholdDemographics    = $true
$IncomeBand               = $true
$Inventory                = $true
$Item                     = $true
$Promotion                = $true
$Reason                   = $true
$ShipMode                 = $true
$Store                    = $true
$StoreSales               = $true  # Store returns is generated as part of store sales.
$TimeDim                  = $true
$Warehouse                = $true
$WebPage                  = $true
$WebSales                 = $true  # Web returns is generated as part of web sales.
$WebSite                  = $true


# How many chunks should be generated for each table?
# CallCenter only generates a single chunk.
# CatalogPage only generates a single chunk.
# CustomerDemographics will generate multiple files but it is not needed even at the 100 TB scale.
# DateDim only generates a single chunk.
# dbgenVersion only generates a single chunk.
# HouseholdDemographics only generates a single chunk.
# IncomeBand only generates a single chunk.
# Item only generates a single chunk.
# Promotion only generates a single chunk.
# Reason only generates a single chunk.
# ShipMode only generates a single chunk.
# Store only generates a single chunk.
# TimeDim only generates a single chunk.
# Warehouse only generates a single chunk.
# WebPage only generates a single chunk.
# WebSite only generates a single chunk.
$ChunksCatalogSales     = 1     # Catalog returns is generated as part of catalog sales and will generate an equal number of files.
$ChunksCustomer         = 1
$ChunksCustomerAddress  = 1
$ChunksInventory        = 1
$ChunksStoreSales       = 1     # Store returns is generated as part of store sales and will generate an equal number of files.
$ChunksWebSales         = 1     # Web returns is generated as part of web sales and will generate an equal number of files.


# Should a specific range of chunks be generated? If so, change the start or end values. A 0 for the chunk start will default to 1. A 0 for the chunk end will default to the max chunk number. This is useful if you need to split the data generation between multiple computers or if something causes a failure in the middle and you would like to pick up where you left off.
# CallCenter only generates a single chunk.
# CatalogPage only generates a single chunk.
# CustomerDemographics will generate multiple files but it is not needed even at the 100 TB scale.
# DateDim only generates a single chunk.
# dbgenVersion only generates a single chunk.
# HouseholdDemographics only generates a single chunk.
# IncomeBand only generates a single chunk.
# Item only generates a single chunk.
# Promotion only generates a single chunk.
# Reason only generates a single chunk.
# ShipMode only generates a single chunk.
# Store only generates a single chunk.
# TimeDim only generates a single chunk.
# Warehouse only generates a single chunk.
# WebPage only generates a single chunk.
# WebSite only generates a single chunk.
$ChunkStartCatalogSales           = 0   # Catalog returns is generated as part of catalog sales and will generate an equal number of files.
$ChunkEndCatalogSales             = 0   # Catalog returns is generated as part of catalog sales and will generate an equal number of files.
$ChunkStartCustomer               = 0
$ChunkEndCustomer                 = 0
$ChunkStartCustomerAddress        = 0
$ChunkEndCustomerAddress          = 0
$ChunkStartInventory              = 0
$ChunkEndInventory                = 0
$ChunkStartStoreSales             = 0   # Store returns is generated as part of store sales and will generate an equal number of files.
$ChunkEndStoreSales               = 0   # Store returns is generated as part of store sales and will generate an equal number of files.
$ChunkStartWebSales               = 0   # Web returns is generated as part of web sales and will generate an equal number of files.
$ChunkEndWebSales                 = 0   # Web returns is generated as part of web sales and will generate an equal number of files.


<#    !!! Only make changes below this line after reviewing and testing the modifications !!!    #>


# Change to the directory that contains dsdgen.
Set-Location $dsdgenDirectory

# Create the top level output directory if it does not exist.
if (!(Test-Path $OutputDirectory)) {
    New-Item -ItemType Directory -Path $OutputDirectory
}

# Set number of parallel data generation threads.
$SetThrottleLimit = Start-ThreadJob -ScriptBlock {Start-Sleep 0} -ThrottleLimit $ParallelJobs
Wait-Job $SetThrottleLimit
Remove-Job $SetThrottleLimit

# Create the function that calls the dsdgen executable which generates the data.
function Invoke-dsdgen {
    param (
        $GenerateData,
        $ScaleFactor,
        $Table,
        $Chunks,
        $ChunkOverrideStart,
        $ChunkOverrideEnd,
        $OutputDirectory
    )

    # If no override values are provided set the starting chunk to 1 and the ending chunk to the total number of chunks. Otherwise, use the override values.
    if ($ChunkOverrideStart -gt 0) {$ChunkStart = $ChunkOverrideStart} else {$ChunkStart = 1}
    if ($ChunkOverrideEnd -gt 0) {$ChunkEnd = $ChunkOverrideEnd} else {$ChunkEnd = $Chunks}

    $ChunkStart..$ChunkEnd | ForEach-Object {
        $Chunk = $_
        
        $ScriptBlock = {
            param (
                $ScaleFactor, 
                $Table, 
                $Chunk, 
                $Chunks, 
                $OutputDirectory
            )
            
            # Tables with only a single chunk.
            if ($Chunks -eq 1) {
                .\dsdgen.exe -dir $OutputDirectory -VERBOSE -FORCE -SCALE $ScaleFactor -TABLE $Table

                if ($Table -eq "catalog_sales") {
                    New-Item -Path (Join-Path -Path $OutputDirectory -ChildPath "catalog_sales")       -ItemType Directory -ErrorAction SilentlyContinue
                    New-Item -Path (Join-Path -Path $OutputDirectory -ChildPath "catalog_returns")     -ItemType Directory -ErrorAction SilentlyContinue
                    Move-Item -Path ("{0}\{1}.dat" -f $OutputDirectory, "catalog_sales")      -Destination (Join-Path -Path $OutputDirectory -ChildPath "catalog_sales")     -Force -ErrorAction SilentlyContinue
                    Move-Item -Path ("{0}\{1}.dat" -f $OutputDirectory, "catalog_returns")    -Destination (Join-Path -Path $OutputDirectory -ChildPath "catalog_returns")   -Force -ErrorAction SilentlyContinue
                }
                elseif ($Table -eq "store_sales") {
                    New-Item -Path (Join-Path -Path $OutputDirectory -ChildPath "store_sales")       -ItemType Directory -ErrorAction SilentlyContinue
                    New-Item -Path (Join-Path -Path $OutputDirectory -ChildPath "store_returns")     -ItemType Directory -ErrorAction SilentlyContinue
                    Move-Item -Path ("{0}\{1}.dat" -f $OutputDirectory, "store_sales")        -Destination (Join-Path -Path $OutputDirectory -ChildPath "store_sales")   -Force -ErrorAction SilentlyContinue
                    Move-Item -Path ("{0}\{1}.dat" -f $OutputDirectory, "store_returns")      -Destination (Join-Path -Path $OutputDirectory -ChildPath "store_returns") -Force -ErrorAction SilentlyContinue
                }
                elseif ($Table -eq "web_sales") {
                    New-Item -Path (Join-Path -Path $OutputDirectory -ChildPath "web_sales")       -ItemType Directory -ErrorAction SilentlyContinue
                    New-Item -Path (Join-Path -Path $OutputDirectory -ChildPath "web_returns")     -ItemType Directory -ErrorAction SilentlyContinue
                    Move-Item -Path ("{0}\{1}.dat" -f $OutputDirectory, "web_sales")          -Destination (Join-Path -Path $OutputDirectory -ChildPath "web_sales")     -Force -ErrorAction SilentlyContinue
                    Move-Item -Path ("{0}\{1}.dat" -f $OutputDirectory, "web_returns")        -Destination (Join-Path -Path $OutputDirectory -ChildPath "web_returns")   -Force -ErrorAction SilentlyContinue
                }
                else {
                    New-Item -Path (Join-Path -Path $OutputDirectory -ChildPath $Table) -ItemType Directory -ErrorAction SilentlyContinue
                    Move-Item -Path ("{0}\{1}.dat" -f $OutputDirectory, $Table) -Destination (Join-Path -Path $OutputDirectory -ChildPath $Table) -Force -ErrorAction SilentlyContinue
                }
            }

            # Tables with multiple chunks. 
            elseif ($Chunks -gt 1) {
                .\dsdgen.exe -dir $OutputDirectory -VERBOSE -FORCE -SCALE $ScaleFactor -PARALLEL $Chunks -CHILD $Chunk -TABLE $Table
            
                if ($Table -eq "catalog_sales") {
                    New-Item -Path (Join-Path -Path $OutputDirectory -ChildPath "catalog_sales")       -ItemType Directory -ErrorAction SilentlyContinue
                    New-Item -Path (Join-Path -Path $OutputDirectory -ChildPath "catalog_returns")     -ItemType Directory -ErrorAction SilentlyContinue
                    Move-Item -Path ("{0}\{1}_{2}_{3}.dat" -f $OutputDirectory, "catalog_sales", $Chunk, $Chunks)      -Destination (Join-Path -Path $OutputDirectory -ChildPath "catalog_sales")     -Force -ErrorAction SilentlyContinue
                    Move-Item -Path ("{0}\{1}_{2}_{3}.dat" -f $OutputDirectory, "catalog_returns", $Chunk, $Chunks)    -Destination (Join-Path -Path $OutputDirectory -ChildPath "catalog_returns")   -Force -ErrorAction SilentlyContinue
                }
                elseif ($Table -eq "store_sales") {
                    New-Item -Path (Join-Path -Path $OutputDirectory -ChildPath "store_sales")       -ItemType Directory -ErrorAction SilentlyContinue
                    New-Item -Path (Join-Path -Path $OutputDirectory -ChildPath "store_returns")     -ItemType Directory -ErrorAction SilentlyContinue
                    Move-Item -Path ("{0}\{1}_{2}_{3}.dat" -f $OutputDirectory, "store_sales", $Chunk, $Chunks)        -Destination (Join-Path -Path $OutputDirectory -ChildPath "store_sales")   -Force -ErrorAction SilentlyContinue
                    Move-Item -Path ("{0}\{1}_{2}_{3}.dat" -f $OutputDirectory, "store_returns", $Chunk, $Chunks)      -Destination (Join-Path -Path $OutputDirectory -ChildPath "store_returns") -Force -ErrorAction SilentlyContinue
                }
                elseif ($Table -eq "web_sales") {
                    New-Item -Path (Join-Path -Path $OutputDirectory -ChildPath "web_sales")       -ItemType Directory -ErrorAction SilentlyContinue
                    New-Item -Path (Join-Path -Path $OutputDirectory -ChildPath "web_returns")     -ItemType Directory -ErrorAction SilentlyContinue
                    Move-Item -Path ("{0}\{1}_{2}_{3}.dat" -f $OutputDirectory, "web_sales", $Chunk, $Chunks)          -Destination (Join-Path -Path $OutputDirectory -ChildPath "web_sales")     -Force -ErrorAction SilentlyContinue
                    Move-Item -Path ("{0}\{1}_{2}_{3}.dat" -f $OutputDirectory, "web_returns", $Chunk, $Chunks)        -Destination (Join-Path -Path $OutputDirectory -ChildPath "web_returns")   -Force -ErrorAction SilentlyContinue
                }
                else {
                    New-Item -Path (Join-Path -Path $OutputDirectory -ChildPath $Table) -ItemType Directory -ErrorAction SilentlyContinue
                    Move-Item -Path ("{0}\{1}_{2}_{3}.dat" -f $OutputDirectory, $Table, $Chunk, $Chunks) -Destination (Join-Path -Path $OutputDirectory -ChildPath $Table) -Force -ErrorAction SilentlyContinue
                }
            }
        }

        if ($Chunks -gt 0 -and $GenerateData -eq $true) {
            $JobName = "Scale Factor: " + $ScaleFactor + " | Table: " + $Table + " | Chunk: "  + ("00000" + $Chunk).Substring(("00000" + $Chunk).Length - 5) + " of " + ("00000" + $Chunks).Substring(("00000" + $Chunks).Length - 5)
            $null = Start-ThreadJob -Name $JobName -ScriptBlock $ScriptBlock -ArgumentList $ScaleFactor, $Table, $Chunk, $Chunks, $OutputDirectory
        }    
    }

}

# Generate the single file datasets.
Invoke-dsdgen -GenerateData $CallCenter            -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "call_center"                -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # call_center
Invoke-dsdgen -GenerateData $CatalogPage           -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "catalog_page"               -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # catalog_page
Invoke-dsdgen -GenerateData $CustomerDemographics  -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "customer_demographics"      -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # customer_demographics
Invoke-dsdgen -GenerateData $DateDim               -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "date_dim"                   -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # date_dim
Invoke-dsdgen -GenerateData $dbgenVersion          -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "dbgen_version"              -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # dbgen_version
Invoke-dsdgen -GenerateData $HouseholdDemographics -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "household_demographics"     -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # household_demographics
Invoke-dsdgen -GenerateData $IncomeBand            -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "income_band"                -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # income_band
Invoke-dsdgen -GenerateData $Item                  -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "item"                       -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # item
Invoke-dsdgen -GenerateData $Promotion             -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "promotion"                  -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # promotion
Invoke-dsdgen -GenerateData $Reason                -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "reason"                     -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # reason
Invoke-dsdgen -GenerateData $ShipMode              -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "ship_mode"                  -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # ship_mode
Invoke-dsdgen -GenerateData $Store                 -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "store"                      -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # store
Invoke-dsdgen -GenerateData $TimeDim               -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "time_dim"                   -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # time_dim
Invoke-dsdgen -GenerateData $Warehouse             -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "warehouse"                  -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # warehouse
Invoke-dsdgen -GenerateData $WebPage               -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "web_page"                   -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # web_page
Invoke-dsdgen -GenerateData $WebSite               -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "web_site"                   -Chunks 1                              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # web_site

# Generate the multi-chunk datasets.
Invoke-dsdgen -GenerateData $CatalogSales          -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "catalog_sales"              -Chunks $ChunksCatalogSales             -ChunkOverrideStart $ChunkStartCatalogSales             -ChunkOverrideEnd $ChunkEndCatalogSales         # catalog_returns and catalog_sales
Invoke-dsdgen -GenerateData $Customer              -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "customer"                   -Chunks $ChunksCustomer                 -ChunkOverrideStart $ChunkStartCustomer                 -ChunkOverrideEnd $ChunkEndCustomer             # customer
Invoke-dsdgen -GenerateData $CustomerAddress       -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "customer_address"           -Chunks $ChunksCustomerAddress          -ChunkOverrideStart $ChunkStartCustomerAddress          -ChunkOverrideEnd $ChunkEndCustomerAddress      # customer_address
Invoke-dsdgen -GenerateData $Inventory             -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "inventory"                  -Chunks $ChunksInventory                -ChunkOverrideStart $ChunkStartInventory                -ChunkOverrideEnd $ChunkEndInventory            # inventory
Invoke-dsdgen -GenerateData $StoreSales            -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "store_sales"                -Chunks $ChunksStoreSales               -ChunkOverrideStart $ChunkStartStoreSales               -ChunkOverrideEnd $ChunkEndStoreSales           # store_returns and store_sales
Invoke-dsdgen -GenerateData $WebSales              -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "web_sales"                  -Chunks $ChunksWebSales                 -ChunkOverrideStart $ChunkStartWebSales                 -ChunkOverrideEnd $ChunkEndWebSales             # web_returns and web_sales


<###### The commands in this section will allow you to monitor the data generation job activity ######>


<#
    # Run this command if you need to pull a list of all the jobs. !! Warning - This could take a long time to run if there are a large number of chunks to generate !!
    Clear-Host
    Get-Job

    # Run this command if you need to pull the details from job with a particular status.
    Clear-Host
    $StateList = "Running", "NotStarted", "Completed"
    Get-Job | Where-Object {$_.State -in $StateList} | Select-Object Id, Name, PSBeginTime, PSEndTime, @{name="Duration[s]"; expression={$End = if ($_.PSEndTime) {$_.PSEndTime} else {Get-Date};(New-TimeSpan -Start $_.PSBeginTime -End $End).TotalSeconds}}, HasMoreData | Format-Table -AutoSize
    
    # Run this command if you need to pull the details from a specific job.
    Clear-Host
    $JobId = 000
    Get-Job -Id $JobId | Select-Object Id, Name, PSBeginTime, PSEndTime, @{name="Duration[s]"; expression={$End = if ($_.PSEndTime) {$_.PSEndTime} else {Get-Date};(New-TimeSpan -Start $_.PSBeginTime -End $End).TotalSeconds}}, HasMoreData | Format-Table -AutoSize

    # Run this command if you need to pull the output data from a specific job.
    Get-Job -Id 0 | Receive-Job -Keep

    # Run this command if you need to pull the output data from all the jobs.  !! Warning - This could take a long time to run if there are a large number of chunks to generate !!
    Get-Job | Receive-Job -Keep

    # Run this command to remove all the completed jobs.
    Get-Job | Where-Object {$_.State -eq "Completed"} | Remove-Job
    
    # Run this command to remove all the jobs.
    Get-Job | Remove-Job
#>
