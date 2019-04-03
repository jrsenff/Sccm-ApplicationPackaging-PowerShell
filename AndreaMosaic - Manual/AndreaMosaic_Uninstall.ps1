<#
    .SYNOPSIS
      SCCM Uninstall program for AndreaMosaic

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - AndreaMosaic

    .NOTES
      FileName: AndreaMosaic_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/28/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AndreaMosaic_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AndreaMosaic_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - AndreaMosaic
$AndreaMosaic= 'AndreaMosaic 3.34.0'
$AndreaMosaicUninstall = ${env:SystemRoot} + '\iun6002.exe'
$AndreaMosaicParams = '"' + ${env:ProgramFiles(x86)} + '\AndreaMosaic\irunin.ini"'
$AndreaMosaicRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\AndreaMosaic'
 
Write-Host ""
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "$AndreaMosaic Uninstaller"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - Uninstall $AndreaMosaic"
Write-Host ""
 
# Uninstall AndreaMosaic
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $AndreaMosaic installation..."
Write-Host ""
 
If ((Test-Path -Path $AndreaMosaicRegkey) -eq 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $AndreaMosaic is installed."
    Write-Host ""
    Write-Host "Uninstalling $AndreaMosaic..."
    Write-Host ""
    Write-Host "Command:  $AndreaMosaicUninstall $AndreaMosaicParams"
    Write-Host ""
    Start-Process -FilePath $AndreaMosaicUninstall -ArgumentList $AndreaMosaicParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $AndreaMosaic uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $AndreaMosaic is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
