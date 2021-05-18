if (((Get-WindowsFeature Web-Server).InstallState -eq "Installed") -ne $False) {
    Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature
} 


Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

if (powershell choco -v) {
    choco install dotnetcore --version=3.1.4 -y
    choco install dotnet-sdk --version=5.0.201 -y 
    choco install dotnetcore-windowshosting -y
    exit
}