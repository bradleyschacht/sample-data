# dbgen parameters.
$dbgenDirectory     = "C:\TPCH\dbgen"    # Directory where dbgen.exe and dists.dss are stored. This is also the directory where the files will be generated and temporarily stored before being moved to the appropriate table specific subdirectory inside the $OutputDirectory.
$OutputDirectory    = "C:\TPCH\GB_001"   # Directory where all the generated files should be stored upon completion. This requires a portion of the script that is commented out.
$ScaleFactor        = 1   # Measured in GB.
$ParallelJobs       = 1   # Number of parallel data generation jobs.


# Which tables should be generated?
$Customer    = $true
$LineItem    = $true
$Nation      = $true
$Orders      = $true
$Part        = $true
$PartSupp    = $true
$Region      = $true
$Supplier    = $true


# How many chunks should be generated for each table?
# Nation only generates a single chunk.
# Region only generates a single chunk.
$ChunksCustomer     = 1
$ChunksLineItem     = 1
$ChunksOrders       = 1
$ChunksPart         = 1
$ChunksPartSupp     = 1
$ChunksSupplier     = 1   


# Should a specific range of chunks be generated? If so, change the start or end values. A 0 for the chunk start will default to 1. A 0 for the chunk end will default to the max chunk number. This is useful if you need to split the data generation between multiple computers or if something causes a failure in the middle and you would like to pick up where you left off.
# Nation only generates a single chunk.
# Region only generates a single chunk.
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


<#    !!! Only make changes below this line after reviewing and testing the modifications !!!    #>


# Change to the directory that contains dbgen.
Set-Location $dbgenDirectory

# Create the top level output directory if it does not exist.
if (!(Test-Path $OutputDirectory)) {
    New-Item -ItemType Directory -Path $OutputDirectory
}

# Set number of parallel data generation threads.
$SetThrottleLimit = Start-ThreadJob -ScriptBlock {Start-Sleep 0} -ThrottleLimit $ParallelJobs
Wait-Job $SetThrottleLimit
Remove-Job $SetThrottleLimit

# Create the function that calls the dbgen executable which generates the data.
function Invoke-dbgen {
    param (
        $GenerateData,
        $ScaleFactor,
        $Table,
        $TableName,
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
                $OutputDirectory, 
                $TableName
            )

            # Create the output directory if it does not exist.
            $OutputSubdirectory = Join-Path -Path $OutputDirectory -ChildPath $TableName
            if (!(Test-Path $OutputSubdirectory)) {
                New-Item -Path $OutputSubdirectory -ItemType Directory
            }
            
            # Tables with only a single chunk.
            if ($Chunks -eq 1) {
                .\dbgen.exe -s $ScaleFactor -T $Table -v -f
                Move-Item -Path ("{0}.tbl" -f $TableName) -Destination $OutputSubdirectory -Force -ErrorAction SilentlyContinue
            }

            # Tables with multiple chunks. 
            elseif ($Chunks -gt 1) {
                .\dbgen.exe -s $ScaleFactor -T $Table -v -f -C $Chunks -S $Chunk
                Move-Item -Path ("{0}.tbl.{1}" -f $TableName, $Chunk) -Destination $OutputSubdirectory -Force -ErrorAction SilentlyContinue
            }
        }

        if ($Chunks -gt 0 -and $GenerateData -eq $true) {
            $JobName = "Scale Factor: " + $ScaleFactor + " | Table: " + $TableName + " | Chunk: "  + ("00000" + $Chunk).Substring(("00000" + $Chunk).Length - 5) + " of " + ("00000" + $Chunks).Substring(("00000" + $Chunks).Length - 5)
            $null = Start-ThreadJob -Name $JobName -ScriptBlock $ScriptBlock -ArgumentList $ScaleFactor, $Table, $Chunk, $Chunks, $OutputDirectory, $TableName
        }    
    }

}

# Generate the single file datasets.
Invoke-dbgen -GenerateData $Nation      -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "n" -TableName "nation"       -Chunks 1                -ChunkOverrideStart 1                   -ChunkOverrideEnd 1                     # nation
Invoke-dbgen -GenerateData $Region      -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "r" -TableName "region"       -Chunks 1                -ChunkOverrideStart 1                   -ChunkOverrideEnd 1                     # region

# Generate the multi-chunk datasets.
Invoke-dbgen -GenerateData $Customer    -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "c" -TableName "customer"     -Chunks $ChunksCustomer -ChunkOverrideStart $ChunkStartCustomer -ChunkOverrideEnd $ChunkEndCustomer     # customer
Invoke-dbgen -GenerateData $LineItem    -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "L" -TableName "lineitem"     -Chunks $ChunksLineItem -ChunkOverrideStart $ChunkStartLineItem -ChunkOverrideEnd $ChunkEndLineItem     # lineitem
Invoke-dbgen -GenerateData $Orders      -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "O" -TableName "orders"       -Chunks $ChunksOrders   -ChunkOverrideStart $ChunkStartOrders   -ChunkOverrideEnd $ChunkEndOrders       # orders
Invoke-dbgen -GenerateData $Part        -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "P" -TableName "part"         -Chunks $ChunksPart     -ChunkOverrideStart $ChunkStartPart     -ChunkOverrideEnd $ChunkEndPart         # part
Invoke-dbgen -GenerateData $PartSupp    -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "S" -TableName "partsupp"     -Chunks $ChunksPartSupp -ChunkOverrideStart $ChunkStartPartSupp -ChunkOverrideEnd $ChunkEndPartSupp     # partsupp
Invoke-dbgen -GenerateData $Supplier    -ScaleFactor $ScaleFactor -OutputDirectory $OutputDirectory -Table "s" -TableName "supplier"     -Chunks $ChunksSupplier -ChunkOverrideStart $ChunkStartSupplier -ChunkOverrideEnd $ChunkEndSupplier     # supplier


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
