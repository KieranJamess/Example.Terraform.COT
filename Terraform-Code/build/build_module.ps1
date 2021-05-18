$modname = "terraform-module"
$modversion = "1.0.0"

$modlocation = (Get-Item $PSScriptRoot).Parent.Parent.FullName + "\Terraform-Module\build"
$modoutput = (Get-Item $PSScriptRoot).Parent.FullName + "\src"
$modulerepopath = (Get-Item $PSScriptRoot).Parent.Parent.FullName + "\ModuleRepo"

$nuspeclocation = (Get-ChildItem $modlocation -Filter *.nuspec).FullName
[xml]$nuspec = Get-Content $nuspeclocation
$nuspec.package.metadata.version = $modversion
$nuspec.Save($nuspeclocation)

nuget.exe pack $nuspeclocation -OutputDirectory $modulerepopath

Get-ChildItem $modoutput | Where-Object {$_.Name -eq $modname} | Remove-Item -Recurse
nuget.exe install $modname -Version $modversion -ExcludeVersion -source $modulerepopath -output $modoutput
