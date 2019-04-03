<#
    .SYNOPSIS
      SCCM Uninstall program for Alpha Five v6

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Uninstall Alpha Five v6

    .NOTES
      FileName: Alpha_Five_V6_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/28/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Alpha_Five_V6_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Alpha_Five_V6_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Alpha Five v6
$AlphaFive = 'Alpha Five v6'
$AlphaFiveUninstall = ${env:SystemDrive} + '\PROGRA~2\A5V6\UNWISE.EXE'
$AlphaFiveParams = ${env:SystemDrive} + '\PROGRA~2\A5V6\INSTALL.LOG'
$AlphaFiveRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Alpha Five V6'
 
Write-Host ""
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "$AlphaFive Uninstaller"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - Uninstall $AlphaFive"
Write-Host ""
 
# Uninstall Alpha Five v6
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $AlphaFive installation..."
Write-Host ""
 
If ((Test-Path -Path $AlphaFiveRegkey) -eq 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $AlphaFive is installed."
    Write-Host ""
    Write-Host "Uninstalling $AlphaFive..."
    Write-Host ""
    Write-Host "Command:  $AlphaFiveUninstall $AlphaFiveParams"
    Write-Host ""
    Start-Process -FilePath $AlphaFiveUninstall -ArgumentList $AlphaFiveParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $AlphaFive uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $AlphaFive is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
