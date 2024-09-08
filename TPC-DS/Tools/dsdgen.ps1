$dsdgenFolder           = "C:\TPCDS\dsdgen"     # Directory where dsdgen.exe and tpcds.idx are stored.
$OutputFolder           = "C:\TPCDS\GB_001"     # Directory where all the generated files should be stored upon completion.
$ScaleFactor            = 1                     # Measured in GB.
$ParallelJobs           = 1                     # Number of parallel data generation jobs.

# Should the following single chunk tables be generated?
$ChunksCallCenter               = 1
$ChunksCatalogPage              = 1
$ChunksCustomerDemographics     = 1     # Customer demographics will generate multiple files but it is not needed.
$ChunksDateDim                  = 1
$ChunksdbgenVersion             = 1
$ChunksHouseholdDemographics    = 1
$ChunksIncomeBand               = 1
$ChunksItem                     = 1
$ChunksPromotion                = 1
$ChunksReason                   = 1
$ChunksShipMode                 = 1
$ChunksStore                    = 1
$ChunksTimeDim                  = 1
$ChunksWarehouse                = 1
$ChunksWebPage                  = 1
$ChunksWebSite                  = 1

# How many chunks should be generated for each table?
$ChunksCatalogSales             = 1     # Catalog returns is generated as part of catalog sales.
$ChunksCustomer                 = 1
$ChunksCustomerAddress          = 1
$ChunksInventory                = 1
$ChunksStoreSales               = 1     # Store returns is generated as part of store sales.
$ChunksWebSales                 = 1     # Web returns is generated as part of web sales.

<# Only make changes below this line after reviewing and testing the modifications. #>

# Which chunks should be generated for each table?
# The following tables only generate a single chunk.
# Call center
# Catalog page
# Date dim only
# dbgen version only
# Household demographics
# Income band
# Item
# Promotion
# Reason
# Ship mode
# Store
# Time dim
# Warehouse
# Web page
# Web site

# The following tables are multi-chunk.
$ChunkStartCatalogSales           = 0   # Catalog returns is generated as part of catalog sales.
$ChunkEndCatalogSales             = 0
$ChunkStartCustomer               = 0
$ChunkEndCustomer                 = 0
$ChunkStartCustomerAddress        = 0
$ChunkEndCustomerAddress          = 0
$ChunkStartInventory              = 0
$ChunkEndInventory                = 0
$ChunkStartStoreSales             = 0   # Store returns is generated as part of store sales.
$ChunkEndStoreSales               = 0
$ChunkStartWebSales               = 0   # Web returns is generated as part of web sales.
$ChunkEndWebSales                 = 0

# Change directory to the folder that contains dsdgen.
Set-Location $dsdgenFolder

# Create the output folder if it does not exist.
if (!(Test-Path $OutputFolder)) {
    New-Item -ItemType Directory -Path $OutputFolder
  }

# Set number of parallel threads.
$SetThrottleLimit = Start-ThreadJob -ScriptBlock {Start-Sleep 0} -ThrottleLimit $ParallelJobs
Wait-Job $SetThrottleLimit
Remove-Job $SetThrottleLimit

function Invoke-dsdgen {
    param (
        $ScaleFactor,
        $Table,
        $Chunks,
        $ChunkOverrideStart,
        $ChunkOverrideEnd
    )

    $ChunkStart = 1
    $ChunkEnd = $Chunks
    
    if ($ChunkOverrideStart -gt 0) {$ChunkStart = $ChunkOverrideStart}
    if ($ChunkOverrideEnd -gt 0) {$ChunkEnd = $ChunkOverrideEnd}

    $ChunkStart..$ChunkEnd | ForEach-Object {

        $Chunk = $_
        $JobName = $Table + " "  + ("00000" + $Chunk).Substring(("00000" + $Chunk).Length - 5) + " of " + ("00000" + $Chunks).Substring(("00000" + $Chunks).Length - 5)

        $ScriptBlock = 
        {
            param($ScaleFactor, $Table, $Chunk, $Chunks, $OutputFolder)

            # Tables with only a single chunk.
            if ($Chunks -eq 1) {
                .\dsdgen.exe -dir $OutputFolder -VERBOSE -FORCE -SCALE $ScaleFactor -TABLE $Table  
            }
            
            # Tables with multiple chunks. 
            elseif ($Chunks -gt 1) {
                .\dsdgen.exe -dir $OutputFolder -VERBOSE -FORCE -SCALE $ScaleFactor -PARALLEL $Chunks -CHILD $Chunk -TABLE $Table
            }
        }

        if ($Chunks -gt 0) {
            $null = Start-ThreadJob -Name $JobName -ScriptBlock $ScriptBlock -ArgumentList $ScaleFactor, $Table, $Chunk, $Chunks, $OutputFolder
        }    
    }

}

<# Generate the single file datasets. #>
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "call_center"                -Chunks $ChunksCallCenter               -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # call_center
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "catalog_page"               -Chunks $ChunksCatalogPage              -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # catalog_page
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "customer_demographics"      -Chunks $ChunksCustomerDemographics     -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # customer_demographics
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "date_dim"                   -Chunks $ChunksDateDim                  -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # date_dim
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "dbgen_version"              -Chunks $ChunksdbgenVersion             -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # dbgen_version
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "household_demographics"     -Chunks $ChunksHouseholdDemographics    -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # household_demographics
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "income_band"                -Chunks $ChunksIncomeBand               -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # income_band
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "item"                       -Chunks $ChunksItem                     -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # item
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "promotion"                  -Chunks $ChunksPromotion                -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # promotion
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "reason"                     -Chunks $ChunksReason                   -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # reason
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "ship_mode"                  -Chunks $ChunksShipMode                 -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # ship_mode
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "store"                      -Chunks $ChunksStore                    -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # store
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "time_dim"                   -Chunks $ChunksTimeDim                  -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # time_dim
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "warehouse"                  -Chunks $ChunksWarehouse                -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # warehouse
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "web_page"                   -Chunks $ChunksWebPage                  -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # web_page
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "web_site"                   -Chunks $ChunksWebSite                  -ChunkOverrideStart 1                                   -ChunkOverrideEnd 1                             # web_site

<# Generate the multi-chunk datasets. #>
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "catalog_sales"              -Chunks $ChunksCatalogSales             -ChunkOverrideStart $ChunkStartCatalogSales             -ChunkOverrideEnd $ChunkEndCatalogSales         # catalog_returns and catalog_sales
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "customer"                   -Chunks $ChunksCustomer                 -ChunkOverrideStart $ChunkStartCustomer                 -ChunkOverrideEnd $ChunkEndCustomer             # customer
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "customer_address"           -Chunks $ChunksCustomerAddress          -ChunkOverrideStart $ChunkStartCustomerAddress          -ChunkOverrideEnd $ChunkEndCustomerAddress      # customer_address
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "inventory"                  -Chunks $ChunksInventory                -ChunkOverrideStart $ChunkStartInventory                -ChunkOverrideEnd $ChunkEndInventory            # inventory
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "store_sales"                -Chunks $ChunksStoreSales               -ChunkOverrideStart $ChunkStartStoreSales               -ChunkOverrideEnd $ChunkEndStoreSales           # store_returns and store_sales
Invoke-dsdgen -ScaleFactor $ScaleFactor -Table "web_sales"                  -Chunks $ChunksWebSales                 -ChunkOverrideStart $ChunkStartWebSales                 -ChunkOverrideEnd $ChunkEndWebSales             # web_returns and web_sales


<#
    # Run this command if you need to pull a list of all the jobs.
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
    Get-Job -Id 2 | Receive-Job -Keep

    # Run this command if you need to pull the output data from all the jobs.
    Get-Job | Receive-Job -Keep

    # Run this command to remove all the completed jobs.
    Get-Job | Where-Object {$_.State -eq "Completed"} | Remove-Job
    
    # Run this command to remove all the jobs.
    Get-Job | Remove-Job
#>

<# Create subdirectories for each table then move files into the appropriate directory.
    $FileList =
        (
            'call_center',
            'catalog_page',
            'catalog_returns',
            'catalog_sales',
            'customer_address',
            'customer_demographics',
            'customer',
            'date_dim',
            'dbgen_version',
            'household_demographics',
            'income_band',
            'inventory',
            'item',
            'promotion',
            'reason',
            'ship_mode',
            'store_returns',
            'store_sales',
            'store',
            'time_dim',
            'warehouse',
            'web_page',
            'web_returns',
            'web_sales',
            'web_site'

        )

    foreach ($FileName in $FileList)
        {
            New-Item -Path (Join-Path -Path $OutputFolder -ChildPath $FileName) -ItemType Directory -ErrorAction SilentlyContinue
            Get-ChildItem -Path $OutputFolder -File "$FileName*" | Move-Item -Destination (Join-Path -Path $OutputFolder -ChildPath $FileName) -Force -ErrorAction SilentlyContinue
        }
#>