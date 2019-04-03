<#
    .SYNOPSIS
      SCCM Uninstall program for 7500 RealTime PCR System (32-bit) 

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - 7500 RealTime PCR System
        - Install folder

    .NOTES
      FileName: 7500RealTimePCRSystem_Manual_Uninstall.ps1
      Author: Jerry Senff
      Updated: 12/06/2016
      Comments: Powershell.exe –executionpolicy bypass –file "7500RealTimePCRSystem_Manual_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\7500RealTimePCRSystem_Manual_Uninstall.txt'
$errFileLocation =  (${env:SystemDrive} + $errorpath)
 
# Uninstall Variables - 7500 RealTime PCR System
$7500System = '7500 RealTime PCR System'
$7500SystemUninstall = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\InstallShield\Driver\8\Intel 32\IDriver.exe"')
$7500SystemParams = '/M{6EC70264-5B14-41F8-8468-CA8841FC18D5}'
$7500SystemRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\InstallShield_{6EC70264-5B14-41F8-8468-CA8841FC18D5}'
$7500InstallFolder = (${env:SystemDrive} + '\Applied Biosystems\7500 System')
 
Write-Host ""
Write-Host "******************************************************************"
Write-Host ""
Write-Host "$7300System Uninstall"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - $7500System"
Write-Host "         - Install folder"
Write-Host ""
 
# Uninstall 7500 RealTime PCR System
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $7500System installation...*"
Write-Host ""
 
If ((Test-Path -Path $7500SystemRegkey) -eq 'True')
{
    Write-Host "    $7500System is installed."
    Write-Host ""
    Write-Host "Uninstalling $7500System..."
    Write-Host ""
    Write-Host "Command: " $7500SystemUninstall $7500SystemParams
    Write-Host ""
    Start-Process -FilePath $7500SystemUninstall -ArgumentList $7500SystemParams -ErrorVariable +err -Verb Open -Wait
    Write-Host "" 
    Write-Host "    $7500System uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $7500System not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
# Delete install folder
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $7500System install folder..."
Write-Host ""
 
if ((Test-Path -Path $7500InstallFolder) -eq 'True')
{
    Write-Host "    $7500System install folder exists."
    Write-Host ""
    Write-Host "Deleting $7500System install folder..."
    Write-Host ""
    Write-Host "Command:  Remove-Item -Path $7500InstallFolder -Recurse -Force"
    Write-Host ""
    Remove-Item -Path $7500InstallFolder -Recurse -Force
    Write-Host ""
    Write-Host "    $7500System install folder deletion complete."
    Write-Host ""
}
else
{
    Write-Host "    $7500System install folder does not exist."
    Write-Host ""
}

Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
Write-Host ""
 
Start-Sleep 5
