function Get-SampleData
    {
        [CmdletBinding()]
        param
            (
                [Parameter(Mandatory)]
                [string] $shared_assets_directory,
                
                [Parameter(Mandatory)]
                [string] $data_directory,

                [Parameter(Mandatory)]
                [string] $activity_log,

                [Parameter(Mandatory)]
                [array] $file_list,

                [Parameter(Mandatory)]
                [bool]$download_data,

                [Parameter(Mandatory)]
                [bool]$process_downloaded_data
            )
        
            [String]$download_directory         = "{0}\Download\" -f $data_directory

            #Load all the shared scripts.
            foreach ($script_to_load in (Get-ChildItem -Path $shared_assets_directory | Where-Object {$_.BaseName -like "Invoke-*"}).FullName) {
                Invoke-Expression -Command ". `"$script_to_load`""
                Write-Host "Loaded $script_to_load"
            }
            
            #Begin logging activity. 
            Start-Transcript -Path $activity_log
            
            #Download all the data from defined in the download file list .
            if ($download_data -eq $true){
                Invoke-DownloadFromUri -download_file_list $file_list -download_directory $download_directory -display_progress_details $true
            }
            
            #Move all non-compressed files to the raw folder. Unpack any compressed files into the raw folder. 
            if ($process_downloaded_data -eq $true){
                Invoke-ProcessDownloadedFiles -download_directory $download_directory -data_directory $data_directory -special_action_file_list $file_list
            }
            
            #Stop logging activity.
            Stop-Transcript

    }