Clear-Host

#Set the parameters for the script.
[String]$shared_assets_directory    = "C:\GitHub\sample-data\Shared Assets\"
[String]$data_directory             = "C:\Sample Data\Data\Adventure Works\"
[String]$activity_log               = "C:\Sample Data\Activity Log\Adventure Works\" + (Get-Date -UFormat "%Y_%m_%dT%H_%M_%S") + ".txt"

#List of files to be downloaded in the format of (SaveAsFileName, ProcessedSubdirectory, URL).
[array]$file_list =
    @(
        @{file_name = "AdventureWorks2008R2.bak"    ; data_subdirectory = "Database Backups\2008\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks2008r2/adventure-works-2008r2-oltp.bak"},
        @{file_name = "AdventureWorksLT2008R2.bak"  ; data_subdirectory = "Database Backups\2008\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks2008r2/adventure-works-2008r2-lt.bak"},
        @{file_name = "AdventureWorksDW2008R2.bak"  ; data_subdirectory = "Database Backups\2008\"; url = "https://github.com/microsoft/sql-server-samples/releases/download/adventureworks2008r2/adventure-works-2008r2-dw.bak"},
        @{file_name = "AdventureWorks2012.bak"      ; data_subdirectory = "Database Backups\2012\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2012.bak"},
        @{file_name = "AdventureWorksDW2012.bak"    ; data_subdirectory = "Database Backups\2012\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2012.bak"},
        @{file_name = "AdventureWorksLT2012.bak"    ; data_subdirectory = "Database Backups\2012\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksLT2012.bak"},
        @{file_name = "AdventureWorks2014.bak"      ; data_subdirectory = "Database Backups\2014\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2014.bak"},
        @{file_name = "AdventureWorksDW2014.bak"    ; data_subdirectory = "Database Backups\2014\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2014.bak"},
        @{file_name = "AdventureWorksLT2014.bak"    ; data_subdirectory = "Database Backups\2014\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksLT2014.bak"},
        @{file_name = "AdventureWorks2016.bak"      ; data_subdirectory = "Database Backups\2016\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2016.bak"},
        @{file_name = "AdventureWorksDW2016.bak"    ; data_subdirectory = "Database Backups\2016\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2016.bak"},
        @{file_name = "AdventureWorksLT2016.bak"    ; data_subdirectory = "Database Backups\2016\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksLT2016.bak"},
        @{file_name = "AdventureWorks2017.bak"      ; data_subdirectory = "Database Backups\2017\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2017.bak"},
        @{file_name = "AdventureWorksDW2017.bak"    ; data_subdirectory = "Database Backups\2017\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2017.bak"},
        @{file_name = "AdventureWorksLT2017.bak"    ; data_subdirectory = "Database Backups\2017\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksLT2017.bak"},
        @{file_name = "AdventureWorks2019.bak"      ; data_subdirectory = "Database Backups\2018\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2019.bak"},
        @{file_name = "AdventureWorksDW2019.bak"    ; data_subdirectory = "Database Backups\2018\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2019.bak"},
        @{file_name = "AdventureWorksLT2019.bak"    ; data_subdirectory = "Database Backups\2018\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksLT2019.bak"},
        @{file_name = "AdventureWorks2022.bak"      ; data_subdirectory = "Database Backups\2022\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2022.bak"},
        @{file_name = "AdventureWorksDW2022.bak"    ; data_subdirectory = "Database Backups\2022\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak"},
        @{file_name = "AdventureWorksLT2022.bak"    ; data_subdirectory = "Database Backups\2022\"; url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksLT2022.bak"},
        @{file_name = "AdventureWorksSamples.zip"       ; data_subdirectory = "Resources\";                                 url = "https://github.com/microsoft/sql-server-samples/archive/refs/tags/adventureworks.zip"},
        @{file_name = "AdventureWorks2008R2.zip"        ; data_subdirectory = "Raw\";                                       url = "https://github.com/microsoft/sql-server-samples/releases/download/adventureworks2008r2/adventure-works-2008r2-oltp-script.zip"},
        @{file_name = "AdventureWorksLT2008R2.zip"      ; data_subdirectory = "Raw\";                                       url = "https://github.com/microsoft/sql-server-samples/releases/download/adventureworks2008r2/adventure-works-2008r2-lt-script.zip"},
        @{file_name = "AdventureWorksDW2008R2.zip"      ; data_subdirectory = "Raw\";                                       url = "https://github.com/microsoft/sql-server-samples/releases/download/adventureworks2008r2/adventure-works-2008r2-dw-script.zip"},
        @{file_name = "AdventureWorks2012.zip"          ; data_subdirectory = "Raw\";                                       url = "https://github.com/microsoft/sql-server-samples/releases/download/adventureworks2012/adventure-works-2012-oltp-script.zip"},
        @{file_name = "AdventureWorksDW2012Images.zip"  ; data_subdirectory = "Resources\";                                 url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks2012/adventure-works-2012-dw-images.zip"},
        @{file_name = "AdventureWorksLT2012.zip"        ; data_subdirectory = "Raw\";                                       url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks2012/adventure-works-2012-oltp-lt-script.zip"},
        @{file_name = "AdventureWorks2014InMemory.zip"  ; data_subdirectory = "Resources\AdventureWorks 2014 In Memory";    url = "https://github.com/microsoft/sql-server-samples/releases/download/adventureworks/adventure-works-2014-oltp-in-memory-sample.zip"},
        @{file_name = "AdventureWorks2017.zip"          ; data_subdirectory = "Raw\AdventureWorks 2017 OLTP";               url = "https://github.com/microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks-oltp-install-script.zip"},
        @{file_name = "AdventureWorksDW2017.zip"        ; data_subdirectory = "Raw\AdventureWorks 2017 DW";                 url = "https://github.com/microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW-data-warehouse-install-script.zip"},
        @{file_name = "AdventureWorks2016.zip"          ; data_subdirectory = "Resources\";                                 url = "https://github.com/microsoft/sql-server-samples/releases/download/adventureworks/sql-server-2016-samples.zip"}
)

<#*********************     Do not change any code beyond this point     *********************#>

#Load the Get-SampleData script.
$script_to_load = "{0}Get-SampleData.ps1" -f $shared_assets_directory
Invoke-Expression -Command ". `"$script_to_load`""
Write-Host "Loaded $script_to_load"

$get_sampledata_parameters = @{
    'shared_assets_directory'   = $shared_assets_directory;
    'data_directory'            = $data_directory;
    'activity_log'              = $activity_log;
    'file_list'                 = $file_list;
    'download_data'             = $true;
    'process_downloaded_data'   = $true;
}

Get-SampleData @get_sampledata_parameters