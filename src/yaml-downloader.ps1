#This is a file downloader. It is not specific to Yaml files. 
$dictionary = New-Object System.Collections.Generic.Dictionary"[String,String]"

#<fileName,url> list of downloads
$dictionary.Add("FileName.yaml", "https://fileToDownloadUrl.com")

$scriptPath = $PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$outSubPath ="$scriptPath\yaml" #directory and path that files will be saved

foreach ($key in $dictionary.Keys) { 
    $url = "$($dictionary[$key])"
    $output = "$outSubPath\$key"
    $start_time = Get-Date

    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($url, $output)

    #Start-BitsTransfer -Source $url -Destination $output
    Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
} 