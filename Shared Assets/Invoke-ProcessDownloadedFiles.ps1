function Invoke-ProcessDownloadedFiles
    {
        [CmdletBinding()]
        param
            (
                [Parameter(Mandatory)]
                [string] $download_directory,
                
                [Parameter(Mandatory)]
                [string] $data_directory,

                [Parameter(Mandatory)]
                [AllowEmptyCollection()]
                [array] $special_action_file_list
            )
        
        $global:download_directory          = $download_directory
        $global:data_directory              = $data_directory
        $global:special_action_file_list    = $special_action_file_list

        Write-Host ""
        Write-Host ""

        foreach ($file in Get-ChildItem -Path $download_directory)
        {
            #Build the full destination directory string.
            $destination_directory = '{0}{1}'-f $data_directory, ($special_action_file_list | Where-Object {$_.file_name -eq $file.Name}).data_subdirectory

            #Check and see if the destination directory exists. If it does not, create it.
            if (-not (Test-Path $destination_directory))
                {
                    $null = New-Item $destination_directory -ItemType directory
                }

            #If the file is not compressed, move it.
            if ($file.Extension -notin(".zip", ".7z", ".gz"))
                {
                    try
                        {
                            Copy-Item -Path $File.FullName -Destination $destination_directory
                            Write-Host ("Copied {0} to {1}" -f $file.FullName, $destination_directory)
                        }
                    catch
                        {
                            Write-Host ("Failed to copy {0} to {1}" -f $file.FullName, $destination_directory)
                        }
                    
                }
            #If the file is compressed, unpack it to the correct directory. 
            elseif ($File.Extension -in (".zip", ".7z", ".gz"))
                {
                    Invoke-UnpackFile -file_to_unpack $file.FullName -unpack_destination_directory $destination_directory
                }
        }

        Write-Host ""
        Write-Host ""
        
    }