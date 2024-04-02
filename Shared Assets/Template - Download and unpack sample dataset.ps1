Clear-Host

#Set the parameters for the script.
[String]$shared_assets_directory    = "C:\GitHub\sample-data\Shared Assets\"
[String]$data_directory             = "C:\Sample Data\Data\DatasetFolderHere\"
[String]$activity_log               = "C:\Sample Data\Activity Log\DatasetFolderHere\" + (Get-Date -UFormat "%Y_%m_%dT%H_%M_%S") + ".txt"

#List of files to be downloaded in the format of (SaveAsFileName, ProcessedSubdirectory, URL).
[array]$file_list =
    @(
        @{file_name = "SaveAsFileName";     data_subdirectory = "Raw\";     url = "URLToDownload"}
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