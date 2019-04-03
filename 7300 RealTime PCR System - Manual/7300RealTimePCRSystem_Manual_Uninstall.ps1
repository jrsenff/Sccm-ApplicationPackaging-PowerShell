<#
    .SYNOPSIS
      SCCM Uninstall program for 7300 RealTime PCR System (32-bit) 

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - 7300 RealTime PCR System
        - Install folder
        - WINXPSP2 compatibility setting – installer
        - WINXPSP2 compatibility setting - uninstaller

    .NOTES
      FileName: 7300RealTimePCRSystem_Manual_Uninstall.ps1
      Author: Jerry Senff
      Updated: 12/06/2016
      Comments: Powershell.exe –executionpolicy bypass –file "7300RealTimePCRSystem_Manual_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\7300RealTimePCRSystem_Manual_Uninstall.ps1.txt'
$errFileLocation =  (${env:SystemDrive} + $errorpath)

# Uninstall Variables - 7300 RealTime PCR System
$7300System = '7300 RealTime PCR System'
$7300SystemUninstall = ${env:ProgramFiles(x86)} + '\Common Files\InstallShield\Driver\1050\Intel 32\IDriver.exe'
$7300SystemParams = '/M{91F0AF32-9452-446D-9A5C-98F47CD11872}'
$7300SystemRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\InstallShield_{91F0AF32-9452-446D-9A5C-98F47CD11872}'
$7300InstallFolder = (${env:SystemDrive} + '\Applied Biosystems\7300 System')
 
# Uninstall Variables - Remove WINXPSP2 compatibility settings
$CompModePath = 'HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers'

$7300InstallValue = 'setup.exe'
$7300InstallSetting = '*setup.exe'

$7300UninstallValue = 'IDriver.exe'
$7300UninstallSetting = '*IDriver.exe'
 
Write-Host ""
Write-Host "******************************************************************"
Write-Host ""
Write-Host "$7300System Uninstall"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - $7300System"
Write-Host "         - Install folder"
Write-Host "         - WINXPSP2 compatibility setting – installer"
Write-Host "         - WINXPSP2 compatibility setting – uninstaller"
Write-Host ""
 
# Uninstall 7300 RealTime PCR System
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $7300System installation..."
Write-Host ""
 
If ((Test-Path -Path $7300SystemRegkey) -eq 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $7300System is installed."
    Write-Host ""
    Write-Host "Uninstalling $7300System..."
    Write-Host ""
    Write-Host "Command:  $7300SystemUninstall $7300SystemParams"
    Write-Host ""
    Start-Process -FilePath $7300SystemUninstall -ArgumentList $7300SystemParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $7300System uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $7300System is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
# Delete install folder
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $7300System install folder..."
Write-Host ""
 
if ((Test-Path -Path $7300InstallFolder) -eq 'True')
{
    Write-Host "    $7300System install folder exists."
    Write-Host ""
    Write-Host "Deleting $7300System install folder..."
    Write-Host ""
    Write-Host "Command:  Remove-Item -Path $7300InstallFolder -Recurse -Force"
    Write-Host ""
    Remove-Item -Path $7300InstallFolder -Recurse -Force
    Write-Host ""
    Write-Host "    $7300System install folder deletion complete."
    Write-Host ""
}
else
{
    Write-Host "    $7300System install folder does not exist."
    Write-Host ""
}
 
Start-Sleep 5
 
#Remove WINXPSP2 compatibility settings - installer
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $7300System installer compatibility setting..."
Write-Host ""
 
if ((Get-ItemProperty $CompModePath) -match $7300InstallValue)
{
    Write-Host "Deleting $7300System installer compatibility setting..."
    Write-Host ""
    Write-Host "Command: Remove-ItemProperty -Path $CompModePath -name $7300InstallSetting -Force"
    Write-Host ""
    Remove-ItemProperty -Path $CompModePath -name $7300InstallSetting -Force
}
else
{
    Write-Host "    $7300System installer compatibility setting does not exist."
    Write-Host ""
}
 
Start-Sleep 5
 
# Remove WINXPSP2 compatibility settings - uninstaller
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $7300System uninstaller compatibility setting..."
Write-Host ""
 
if ((Get-ItemProperty $CompModePath) -match $7300UninstallValue)
{
    Write-Host "Deleting $7300System uninstaller compatibility setting..."
    Write-Host ""
    Write-Host "Command: Remove-ItemProperty -Path $CompModePath -name $7300UninstallSetting -Force"
    Write-Host ""
    Remove-ItemProperty -Path $CompModePath -name $7300UninstallSetting -Force
}
else
{
    Write-Host "    $7300System uninstaller compatibility setting does not exist."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
Write-Host ""
 
Start-Sleep 5
