function Invoke-DownloadFromUri
    {
        [CmdletBinding()]
        param
            (
                [Parameter(Mandatory)]
                [array] $download_file_list,

                [Parameter(Mandatory)]
                [string] $download_directory,

                [Parameter()]
                [bool] $display_progress_details = $true
            )

        Write-Host ""
        Write-Host ""

        #Check and see if the source directory exists. If it does not, create it.
        if (-not (Test-Path $download_directory)) {
            $null = New-Item $download_directory -ItemType directory
        }
        
        foreach ($download_file_current in $download_file_list) {

            $download_uri = $download_file_current.url
            $download_file_path = $download_directory + $download_file_current.file_name
  
            $global:download_retry_count = 0
            $global:download_complete = $false
            $global:display_progress_details = $display_progress_details
            $global:progress_activity = "Downloading {0}" -f $download_uri
            
            while (-not $global:download_complete)
            {
                try
                    {
                        $global:download_percent_complete = 0
                        $global:download_start_date = Get-Date

                        $web_client = New-Object System.Net.WebClient

                        $download_progress = Register-ObjectEvent -InputObject $web_client -EventName DownloadProgressChanged -Action {
                            if ($event.sourceEventArgs.ProgressPercentage -gt $global:download_percent_complete)
                                {
                                switch ($event.sourceEventArgs.TotalBytesToReceive)
                                    {
                                        #MB greater than or equal to 1,000,000  and less than 1,000,000,000 bytes (1MB to 1GB)
                                        {$event.sourceEventArgs.TotalBytesToReceive -ge 1000000 -and $event.sourceEventArgs.TotalBytesToReceive -lt 1000000000}
                                            {
                                                $global:download_bytes_conversion = "1MB"
                                                $global:download_size_label = "MB"
                                            }
                                        #GB greater than 1,000,000,000 bytes (1GB and larger)
                                        {$event.sourceEventArgs.TotalBytesToReceive -ge 1000000000}
                                            {
                                                $global:download_bytes_conversion = "1GB"
                                                $global:download_size_label = "GB"
                                            }
                                        #Bytes
                                        Default
                                            {
                                                $global:download_bytes_conversion = 1
                                                $global:download_size_label = "bytes"
                                            }
                                    }
                                
                                $global:download_percent_complete = $event.sourceEventArgs.ProgressPercentage
                                $global:download_time_elapsed = ([Math]::Round($((Get-Date) - $global:download_start_date).TotalSeconds)).ToString()
                                $global:download_size_total = ([Math]::Round($event.sourceEventArgs.TotalBytesToReceive/$global:download_bytes_conversion, 2)).ToString()
                                $global:download_size_completed = ([Math]::Round($event.sourceEventArgs.BytesReceived/$global:download_bytes_conversion, 2)).ToString()

                                if ($global:display_progress_details -eq $true)
                                    {
                                        Write-Progress `
                                            -Activity $global:progress_activity `
                                            -Status $("{0}% downloaded in {1} seconds. {2} of {3} {4} downloaded." -f $global:download_percent_complete, $global:download_time_elapsed, $global:download_size_completed, $global:download_size_total, $global:download_size_label) `
                                            -PercentComplete $global:download_percent_complete
                                    }
                                
                                }
                            
                        }

                        $web_client.DownloadFileAsync($download_uri, $download_file_path)

                        while ($web_client.IsBusy)
                            {
                                Start-Sleep -Milliseconds 100
                            }

                        #Cleanup the download background processes.
                        $web_client.Dispose()
                        Write-Progress -Activity $global:progress_activity -Status "Download complete." -Completed
                        Remove-Job $download_progress -Force
                        Get-EventSubscriber | Where-Object SourceObject -eq $web_client | Unregister-Event -Force

                        $global:download_complete = $true
                        Write-Host $("{0} downloaded {1} {2} in {3} seconds." -f $download_uri, $global:download_size_total, $global:download_size_label, $global:download_time_elapsed)

                    }
                catch
                    {
                        if ($global:download_retry_count -ge 5)
                            {
                                $global:download_complete = $true
                                Write-Host "Failed to download $download_uri" -ForegroundColor Red
                            }
                        else
                            {
                                $global:download_retry_count++
                            }

                        }
            }

        }
    }