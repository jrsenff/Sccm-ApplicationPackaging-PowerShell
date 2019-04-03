<#
    .SYNOPSIS
      SCCM Uninstall program for BarTender 10

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - BarTender 10

    .NOTES
      FileName: BarTender10_Manual_Uninstall.ps1
      Author: Jerry Senff
      Updated: 04/02/2019
      Comments: Powershell.exe –executionpolicy bypass –file "BarTender10_Manual_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\BarTender10_Manual_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - BarTender 10
$MsiExec = (${env:SystemRoot} + '\System32\msiexec.exe')
$AppName1 = 'Bartender 10'
$AppName1Uninstall = (${env:ProgramData} + '\Seagull\Installer\RunElevated.exe')
$AppName1Params = ($MsiExec + ' /X {9F353F1D-97E4-411A-BE6D-CBDC680B3360} /q')
$AppName1Regkey = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BarTender Suite'
 
Write-Host ""
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "$AppName1 Uninstaller"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - Uninstall $AppName1"
Write-Host ""
 
# Uninstall BarTender 10
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for BarTender 10 installation...*"
Write-Host ""

If ((Test-Path -Path $AppName1Regkey) -eq 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $AppName1 is installed."
    Write-Host ""
    Write-Host "Uninstalling $AppName1..."
    Write-Host ""
    Write-Host "Command:  $AppName1Uninstall $AppName1Params"
    Write-Host ""
    Start-Process -FilePath $AppName1Uninstall -ArgumentList $AppName1Params -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $AppName1 uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $AppName1 is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
