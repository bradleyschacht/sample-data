Clear-Host

#Set the parameters for the script.
[String]$shared_assets_directory    = "C:\GitHub\sample-data\Shared Assets\"
[String]$data_directory             = "C:\Sample Data\Data\Stack Overflow\"
[String]$activity_log               = "C:\Sample Data\Activity Log\Stack Overflow\" + (Get-Date -UFormat "%Y_%m_%dT%H_%M_%S") + ".txt"

#List of files to be downloaded in the format of (SaveAsFileName, ProcessedSubdirectory, URL).
[array]$file_list =
    @(
        @{file_name = "Badges.7z";      data_subdirectory = "Raw\"; url = "https://archive.org/download/stackexchange/stackoverflow.com-Badges.7z"},
        @{file_name = "Comments.7z";    data_subdirectory = "Raw\"; url = "https://archive.org/download/stackexchange/stackoverflow.com-Comments.7z"},
        @{file_name = "PostHistory.7z"; data_subdirectory = "Raw\"; url = "https://archive.org/download/stackexchange/stackoverflow.com-PostHistory.7z"},
        @{file_name = "PostLinks.7z";   data_subdirectory = "Raw\"; url = "https://archive.org/download/stackexchange/stackoverflow.com-PostLinks.7z"},
        @{file_name = "Posts.7z";       data_subdirectory = "Raw\"; url = "https://archive.org/download/stackexchange/stackoverflow.com-Posts.7z"},
        @{file_name = "Tags.7z";        data_subdirectory = "Raw\"; url = "https://archive.org/download/stackexchange/stackoverflow.com-Tags.7z"},
        @{file_name = "Users.7z";       data_subdirectory = "Raw\"; url = "https://archive.org/download/stackexchange/stackoverflow.com-Users.7z"},
        @{file_name = "Votes.7z";       data_subdirectory = "Raw\"; url = "https://archive.org/download/stackexchange/stackoverflow.com-Votes.7z"}
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