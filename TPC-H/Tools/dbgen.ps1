$dbgenFolder            = "C:\TPCH"         # Directory where dbgen.exe and dists.dss are stored.
$OutputFolder           = "C:\TPCH\GB_001"  # Directory where all the generated files should be stored upon completion. This requires a portion of the script that is commented out.
$ScaleFactor            = 1                 # Measured in GB.
$ParallelJobs           = 1                 # Number of parallel data generation jobs.

# Should the following single chunk tables be generated?
$ChunksNation       = 1
$ChunksRegion       = 1

# How many chunks should be generated for each table?
$ChunksCustomer     = 1
$ChunksLineItem     = 1
$ChunksOrders       = 1
$ChunksPart         = 1
$ChunksPartSupp     = 1
$ChunksSupplier     = 1

<# Only make changes below this line after reviewing and testing the modifications. #>

# Which chunks should be generated for each table?
# The following tables only generate a single chunk.
# nation
# region

# The following tables are multi-chunk.
$ChunkStartCustomer     = 0
$ChunkEndCustomer       = 0
$ChunkStartLineItem     = 0
$ChunkEndLineItem       = 0
$ChunkStartOrders       = 0
$ChunkEndOrders         = 0
$ChunkStartPart         = 0
$ChunkEndPart           = 0
$ChunkStartPartSupp     = 0
$ChunkEndPartSupp       = 0
$ChunkStartSupplier     = 0
$ChunkEndSupplier       = 0

# Change directory to the folder that contains dbgen.
Set-Location $dbgenFolder

# Set number of parallel threads.
$SetThrottleLimit = Start-ThreadJob -ScriptBlock {Start-Sleep 0} -ThrottleLimit $ParallelJobs
Wait-Job $SetThrottleLimit
Remove-Job $SetThrottleLimit

function Invoke-dbgen {
    param (
        $ScaleFactor,
        $Table,
        $TableName,
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
        $JobName = $TableName + " "  + ("00000" + $Chunk).Substring(("00000" + $Chunk).Length - 5) + " of " + ("00000" + $Chunks).Substring(("00000" + $Chunks).Length - 5)

        $ScriptBlock = 
        {
            param($ScaleFactor, $Table, $Chunk, $Chunks)
            
            # Tables with only a single chunk.
            if ($Chunks -eq 1) {
                .\dbgen.exe -s $ScaleFactor -T $Table -v -f
            }

            # Tables with multiple chunks. 
            elseif ($Chunks -gt 1) {
                .\dbgen.exe -s $ScaleFactor -T $Table -v -f -C $Chunks -S $Chunk
            }
        }

        if ($Chunks -gt 0) {
            $null = Start-ThreadJob -Name $JobName -ScriptBlock $ScriptBlock -ArgumentList $ScaleFactor, $Table, $Chunk, $Chunks
        }    
    }

}

<# Generate the single file datasets. #>
Invoke-dbgen -ScaleFactor $ScaleFactor -Table "n" -TableName "nation"       -Chunks $ChunksNation   -ChunkOverrideStart 1                   -ChunkOverrideEnd 1                     # nation
Invoke-dbgen -ScaleFactor $ScaleFactor -Table "r" -TableName "region"       -Chunks $ChunksRegion   -ChunkOverrideStart 1                   -ChunkOverrideEnd 1                     # region

<# Generate the multi-chunk datasets. #>
Invoke-dbgen -ScaleFactor $ScaleFactor -Table "c" -TableName "customer"     -Chunks $ChunksCustomer -ChunkOverrideStart $ChunkStartCustomer -ChunkOverrideEnd $ChunkEndCustomer     # customer
Invoke-dbgen -ScaleFactor $ScaleFactor -Table "L" -TableName "lineitem"     -Chunks $ChunksLineItem -ChunkOverrideStart $ChunkStartLineItem -ChunkOverrideEnd $ChunkEndLineItem     # lineitem
Invoke-dbgen -ScaleFactor $ScaleFactor -Table "O" -TableName "orders"       -Chunks $ChunksOrders   -ChunkOverrideStart $ChunkStartOrders   -ChunkOverrideEnd $ChunkEndOrders       # orders
Invoke-dbgen -ScaleFactor $ScaleFactor -Table "P" -TableName "part"         -Chunks $ChunksPart     -ChunkOverrideStart $ChunkStartPart     -ChunkOverrideEnd $ChunkEndPart         # part
Invoke-dbgen -ScaleFactor $ScaleFactor -Table "S" -TableName "partsupp"     -Chunks $ChunksPartSupp -ChunkOverrideStart $ChunkStartPartSupp -ChunkOverrideEnd $ChunkEndPartSupp     # partsupp
Invoke-dbgen -ScaleFactor $ScaleFactor -Table "s" -TableName "supplier"     -Chunks $ChunksSupplier -ChunkOverrideStart $ChunkStartSupplier -ChunkOverrideEnd $ChunkEndSupplier     # supplier

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
    # Create the output folder if it does not exist.
    if (!(Test-Path $OutputFolder)) {
        New-Item -ItemType Directory -Path $OutputFolder
    }

    # Move files into subfolders. Make sure to move partsupp before part due to string matching.
    $FileList =
        (
            'customer', 
            'lineitem', 
            'nation', 
            'orders', 
            'partsupp', 
            'part', 
            'region', 
            'supplier'
        )

    foreach ($FileName in $FileList)
        {
            New-Item -Path (Join-Path -Path $OutputFolder -ChildPath $FileName) -ItemType Directory -ErrorAction SilentlyContinue
            Get-ChildItem -File "$FileName*" | Move-Item -Destination (Join-Path -Path $OutputFolder -ChildPath $FileName) -Force -ErrorAction SilentlyContinue
        }
#>
