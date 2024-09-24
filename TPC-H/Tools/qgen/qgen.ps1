# qgen parameters.
$qgenDirectory      = "C:\TPC-H\Tools\qgen"         # Directory where qgen.exe, dists.dss, and the 22 sql template files are stored.
$OutputDirectory    = "C:\TPC-H\Tools\qgen\Queries" # Directory where the generated queries will be stored.
$SeedValue          = 081310311                     # Seed value for the random number generator. According to the spec this values should be the time stamp of the end of the database load time expressed in the format mmddhhmmss where mm is the month, dd the day, hh the hour, mm the minutes and ss the seconds.

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

# Change to the directory that contains qgen.
Set-Location $qgenDirectory

# Create the output directory if it does not exist.
if (!(Test-Path $OutputDirectory)) {
    New-Item -ItemType Directory -Path $OutputDirectory
}

# Store the full location of qgen.exe.
$qgen = Join-Path -Path $qgenDirectory -ChildPath "qgen.exe"

Clear-Host
if ($GB_001) {& $qgen -v -c -s 1        -r $SeedValue >> (Join-Path -Path $OutputDirectory -ChildPath ("TPCH_{0}_GB_001.sql" -f $SeedValue))}
if ($GB_010) {& $qgen -v -c -s 10       -r $SeedValue >> (Join-Path -Path $OutputDirectory -ChildPath ("TPCH_{0}_GB_010.sql" -f $SeedValue))}
if ($GB_030) {& $qgen -v -c -s 30       -r $SeedValue >> (Join-Path -Path $OutputDirectory -ChildPath ("TPCH_{0}_GB_030.sql" -f $SeedValue))}
if ($GB_100) {& $qgen -v -c -s 100      -r $SeedValue >> (Join-Path -Path $OutputDirectory -ChildPath ("TPCH_{0}_GB_100.sql" -f $SeedValue))}
if ($GB_300) {& $qgen -v -c -s 300      -r $SeedValue >> (Join-Path -Path $OutputDirectory -ChildPath ("TPCH_{0}_GB_300.sql" -f $SeedValue))}
if ($TB_001) {& $qgen -v -c -s 1000     -r $SeedValue >> (Join-Path -Path $OutputDirectory -ChildPath ("TPCH_{0}_TB_001.sql" -f $SeedValue))}
if ($TB_003) {& $qgen -v -c -s 3000     -r $SeedValue >> (Join-Path -Path $OutputDirectory -ChildPath ("TPCH_{0}_TB_003.sql" -f $SeedValue))}
if ($TB_010) {& $qgen -v -c -s 10000    -r $SeedValue >> (Join-Path -Path $OutputDirectory -ChildPath ("TPCH_{0}_TB_010.sql" -f $SeedValue))}
if ($TB_030) {& $qgen -v -c -s 30000    -r $SeedValue >> (Join-Path -Path $OutputDirectory -ChildPath ("TPCH_{0}_TB_030.sql" -f $SeedValue))}
if ($TB_100) {& $qgen -v -c -s 100000   -r $SeedValue >> (Join-Path -Path $OutputDirectory -ChildPath ("TPCH_{0}_TB_100.sql" -f $SeedValue))}