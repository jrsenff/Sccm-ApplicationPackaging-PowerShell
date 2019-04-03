<#
    .SYNOPSIS
      SCCM install program for 7300 RealTime PCR System (32-bit) 

    .DESCRIPTION
      Install the following component(s) on Window 7 x64 systems:
        - Set compatibility mode to WINXPSP2 RUNASADMIN - installer 
        - Install 7300 RealTime PCR System (32-bit)
        - Set compatibility mode to WINXPSP2 RUNASADMIN - uninstaller

    .NOTES
      FileName: 7300RealTimePCRSystem_Manual_Install.ps1
      Author: Jerry Senff
      Updated: 12/06/2016
      Comments: Powershell.exe –executionpolicy bypass –file "7300RealTimePCRSystem_Manual_Install.ps1"
#>

# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\7300RealTimePCRSystem_Manual_Install.txt'
$errFileLocation =  (${env:SystemDrive} + $errorpath)

# Set compatibility mode to WINXPSP2 RUNASADMIN - installer and uninstaller
$CompModePath = 'HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers'
$CompMode = 'WINXPSP2 RUNASADMIN'
$7300InstallValue = 'setup.exe'
$7300UninstallValue = 'IDriver.exe'

# Install 7300 RealTime PCR System (32-bit)
$7300System = '7300 RealTime PCR System'
$7300SystemInstall = ('' + $startLocation + '\setup.exe')
$7300SystemUninstall = ${env:ProgramFiles(x86)} + '\Common Files\InstallShield\Driver\1050\Intel 32\IDriver.exe'
$7300SystemRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\InstallShield_{91F0AF32-9452-446D-9A5C-98F47CD11872}'

Write-Host ""
Write-Host "******************************************************************"
Write-Host ""
Write-Host "$7300System Install"
Write-Host ""
Write-Host "Purpose: Install the following components:"
Write-Host "         - Set installer compatibility mode to $CompMode"
Write-Host "         - Install $7300System"
Write-Host "         - Set uninstaller compatibility mode to $CompMode"
Write-Host ""
 
# Set compatibility mode to WINXPSP2 RUNASADMIN - installer
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $7300System installer compatibility mode setting..."
Write-Host ""
 
if ((Get-ItemProperty $CompModePath) -match $7300InstallValue)
{
    Write-Host "    $7300System installer compatibility mode setting already exists."
    Write-Host ""
}
else
{
    Write-Host "Setting $7300System installer compatibility mode to $CompMode..."
    Write-Host ""
    Write-Host "Command: New-ItemProperty -Path $CompModePath -name $7300SystemInstall -Value $CompMode"
    Write-Host ""
    New-ItemProperty -Path $CompModePath -Name $7300SystemInstall -Value $CompMode
    Write-Host ""
    Write-Host "    $7300System installer compatibility mode setting complete."
    Write-Host ""
}
 
Start-Sleep 5
 
# Install 7300 RealTime PCR System (32-bit)
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $7300System installation..."
Write-Host ""
 
If ((Test-Path -Path $7300SystemRegkey) -ne 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $7300System is not installed."
    Write-Host ""
    Write-Host "Installing $7300System..."
    Write-Host ""
    Write-Host "Command:  $7300SystemInstall"
    Write-Host ""
    Start-Process -FilePath $7300SystemInstall -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $7300System install complete."
    Write-Host ""
}
Else
{
    Write-Host "    $7300System is already installed."
    Write-Host ""
}
 
Start-Sleep 5
 
# Set compatibility mode to WINXPSP2 RUNASADMIN - uninstaller
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $7300System uninstaller compatibility mode setting..."
Write-Host ""
 
if ((Get-ItemProperty $CompModePath) -match $7300UninstallValue)
{
    Write-Host "    $7300System uninstaller compatibility mode setting already exists."
    Write-Host ""
}
else
{
    Write-Host "Setting $7300System uninstaller compatibility mode to $CompMode..."
    Write-Host ""
    Write-Host "Command: New-ItemProperty -Path $CompModePath -name $7300SystemUninstall -Value $CompMode"
    Write-Host ""
    New-ItemProperty -Path $CompModePath -Name $7300SystemUninstall -Value $CompMode
    Write-Host ""
    Write-Host "    $7300System uninstaller compatibility mode setting complete."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
Write-Host ""
 
Start-Sleep 5
