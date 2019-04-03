<#
    .SYNOPSIS
      SCCM Uninstall program for Avidemux

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Avidemux

    .NOTES
      FileName: Avidemux_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/28/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Avidemux_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Avidemux_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Avidemux
$Avidemux = 'Avidemux 2.6 - 64bits'
$AvidemuxUninstall = '"' + ${env:ProgramFiles} + '\Avidemux 2.6 - 64bits\uninstall.exe"'
$AvidemuxParams = '/S'
$AvidemuxRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Avidemux 2.6 - 64bits (64-bit)'
 
Write-Host ""
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "$Avidemux Uninstaller"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - Uninstall $Avidemux"
Write-Host ""
 
#  Uninstall Avidemux
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $Avidemux installation..."
Write-Host ""
 
If ((Test-Path -Path $AvidemuxRegkey) -eq 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $Avidemux is installed."
    Write-Host ""
    Write-Host "Uninstalling $Avidemux..."
    Write-Host ""
    Write-Host "Command:  $AvidemuxUninstall $AvidemuxParams"
    Write-Host ""
    Start-Process -FilePath $AvidemuxUninstall -ArgumentList $AvidemuxParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $Avidemux uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $Avidemux is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
