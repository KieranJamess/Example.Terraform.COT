Param (
    
    [Parameter(Mandatory = $false)]
    [string]
    $testdir = (Get-Item $PSScriptRoot).Parent.FullName + '\src'
)

$currentlocation = Get-Location
$testdir = (Get-Item $testdir).FullName
$tfSources = Get-ChildItem -Path $testdir -filter *.tf -File
if ($tfSources) {
    Set-Location $testdir
    Write-Information $testdir
    Write-host "initiating in $testdir"
    & 'terraform' @('init', '-backend=false')
    if ($LASTEXITCODE -ne 0) {
        Throw "Terraform Init Failed"
    }
    & 'terraform' @('validate')
    if ($LASTEXITCODE -ne 0) {
        Write-Information "Running terraform validate in $($testdir)"
        Throw "Terraform Validate Failed"
    }        
} else {Write-Warning "No tf files found"}
Set-Location $currentlocation