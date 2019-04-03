<#
    .SYNOPSIS
      SCCM Install program for BarTender 10 

    .DESCRIPTION
      Install the following component(s) on Window 7 x64 systems:
        - BarTender 10

    .NOTES
      FileName: BarTender10_Manual_Install.ps1
      Author: Jerry Senff
      Updated: 04/02/2019
      Comments: Powershell.exe –executionpolicy bypass –file "BarTender10_Manual_Install.ps1"
#>

# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\BarTender10_Manual_Install.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Install variables - BarTender 10
$MsiExec = (${env:SystemRoot} + '\System32\msiexec.exe')
$AppName1 = 'BarTender 10'
$AppName1Params = '/i "BarTender.msi" /t "BarTender.mst" /qf /norestart'
$AppName1Regkey = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BarTender Suite'

Write-Host ""
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "$AppName1 Installer"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - Install $AppName1"
Write-Host ""
 
# Install BarTender 10
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $AppName1 installation..."
Write-Host ""
 
If ((Test-Path -Path $AppName1Regkey) -ne 'True')
{
    Write-Host "    $AppName1 is not installed."
    Write-Host ""
    Write-Host "Installing $AppName1..."
    Write-Host ""
    Write-Host "Command: " $MsiExec $AppName1Params
    Write-Host ""
    Start-Process -FilePath $MsiExec -ArgumentList $AppName1Params -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $AppName1 install complete."
    Write-Host ""
}
Else
{
    Write-Host "    $AppName1 already installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
