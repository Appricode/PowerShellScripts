#This scripts generates C# .cs models by looking to a Yaml files in a directory. 
#You need to custimize according to your needs

$files =  Get-ChildItem $PSScriptRoot"/yaml" -Filter *.yaml 
$scriptPath = $PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$outSubPath ="\Models\Generated"

foreach ($f in $files){
    
$out = Split-Path -Parent -Path $scriptPath
$inputFile = $f.FullName 
$namespace = "FileNamePrefix."+ $f.Basename + ".Models" #todo change this according to your code
$modelFile = $f.Basename + "Models.cs"

Write-Host "Yaml file name : $inputFile"
Write-Host "Generated Name Space : $namespace"

$ValidateCommand = "swagger-cli validate $inputFile"
$Command = "nswag openapi2csclient /Namespace:$namespace /Input:$inputFile /GenerateClientClasses:false /GenerateContractsOutput:true /ContractsNamespace:$namespace  /ContractsOutput:$out\$outSubPath\$modelFile /output:$out\$outSubPath\deleteme.cs"

Write-Host "Generated Model File : $modelFile"

Invoke-Expression $ValidateCommand
Invoke-Expression $Command

Remove-Item "$out\$outSubPath\deleteme.cs"
Write-Host "Code Generation Competed"
}