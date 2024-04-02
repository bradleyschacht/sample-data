function Invoke-UnpackFile
    {
        [CmdletBinding()]
        param
            (
                [Parameter(Mandatory)]
                [string] $file_to_unpack,
                
                [Parameter(Mandatory)]
                [string] $unpack_destination_directory
            )
        
        $global:file_to_unpack = $file_to_unpack
        $global:unpack_destination_directory = $unpack_destination_directory

        #Check and see if the destination directory exists. If it does not, create it.
        if (-not (Test-Path $unpack_destination_directory)) {
            $null = New-Item $unpack_destination_directory -ItemType directory
        }
                
        #Write-Host ("File Path: {0}" -f $file_to_unpack)
        #Write-Host ("Destination Path: {0}" -f $unpack_destination_directory)

        if ((Get-Item -Path $file_to_unpack).Extension -eq ".zip")
            {
                try
                    {
                        Expand-Archive -Path $file_to_unpack -DestinationPath $unpack_destination_directory -Force
                        Write-Host ("Unzipped {0} to {1}" -f $file_to_unpack, $unpack_destination_directory)
                    }
                catch
                    {
                        Write-Host ("Unzip Failed on {0}" -f $file_to_unpack) -ForegroundColor Red
                    }
            }
        elseif ((Get-Item -Path $file_to_unpack).Extension -in (".7z", ".gz"))
            {
                #Check for the 7Zip module and install if necessary. 
                if (Get-InstalledModule -Name "7Zip4PowerShell") {}
                else
                {
                    Write-Host "7Zip4PowerShell module is not found. Attempting installtion." -ForegroundColor Green
                    
                    try
                        {
                            Install-Module -Name 7Zip4PowerShell -Force
                        }
                    catch
                        {
                            Write-Host ("Installing the 7Zip Module failed with the error message: {0}" -f $_.Exception.Message) -ForegroundColor Red
                            Write-Host "Attempting to install with -Scope CurrentUser" -ForegroundColor Red
                            try
                                {
                                    Install-Module -Name 7Zip4PowerShell -Force -Scope CurrentUser
                                }
                            catch
                                {
                                    Write-Host ("Installing the 7Zip Module with -Scope CurrentUser failed with the error message: {0}" -f $_.Exception.Message) -ForegroundColor Red
                                }
                        }
                }
                
                if ((Get-Item -Path $file_to_unpack).Extension -eq (".7z"))
                    {
                        #Unpack the 7z file.
                        try
                            {
                                Expand-7Zip -ArchiveFileName $file_to_unpack -TargetPath $unpack_destination_directory
                                Write-Host ("Unzipped {0} to {1}" -f $file_to_unpack, $unpack_destination_directory)
                            }
                        catch
                            {
                                Write-Host ("Unzip Failed on {0}" -f $file_to_unpack) -ForegroundColor Red
                            }        
                    }
                
                if ((Get-Item -Path $file_to_unpack).Extension -eq (".gz"))
                    {
                        #Unpack the gz file.
                        try
                            {
                                $target_path = $unpack_destination_directory + (Get-Item -Path $file_to_unpack).BaseName
                                
                                $gz_file = New-Object System.IO.FileStream $file_to_unpack, ([IO.FileMode]::Open), ([IO.FileAccess]::Read), ([IO.FileShare]::Read)
                                $target_file = New-Object System.IO.FileStream $target_path, ([IO.FileMode]::Create), ([IO.FileAccess]::Write), ([IO.FileShare]::None)
                                $gz_stream = New-Object System.IO.Compression.GzipStream $gz_file, ([IO.Compression.CompressionMode]::Decompress)

                                $buffer = New-Object byte[](1024)
                                while($true){
                                    $read = $gz_stream.Read($buffer, 0, 1024)
                                    if ($read -le 0){break}
                                    $target_file.Write($buffer, 0, $read)
                                    }

                                $gz_stream.Close()
                                $target_file.Close()
                                $gz_file.Close()
                                Write-Host ("Unzipped {0} to {1}" -f $file_to_unpack, $unpack_destination_directory)
                            }
                        catch
                            {
                                Write-Host ("Unzip Failed on {0}" -f $file_to_unpack) -ForegroundColor Red
                            }        
                    }
                
                
                
            }
    }