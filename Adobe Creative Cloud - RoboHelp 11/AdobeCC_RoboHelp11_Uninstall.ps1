<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe RoboHelp 11 Creative Cloud

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe RoboHelp 11

    .NOTES
      FileName: AdobeCC_RoboHelp11_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/26/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_RoboHelp11_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_RoboHelp11_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe RoboHelp 11 Creative Cloud
$AdobeUninstaller = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"')
$ccRoboHelp11Params = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{2A3F7147-8786-466F-B89A-C56131033A3B}"'
$ccRoboHelp11Regkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{2A3F7147-8786-466F-B89A-C56131033A3B}'
 
Write-Host ""
Write-Host "******** Adobe ccRoboHelp 11 Uninstaller ***********************************"
Write-Host ""
Write-Host "Purpose: Uninstall Adobe ccRoboHelp 11"
Write-Host ""
 
# Uninstalls Adobe ccRoboHelp 11
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe ccRoboHelp 11 installation...*"
Write-Host ""
 
If ((Test-Path -Path $ccRoboHelp11Regkey) -eq 'True')
{
    Write-Host "    Adobe ccRoboHelp 11 is installed."
    Write-Host ""
    Write-Host "Uninstalling Adobe ccRoboHelp 11..."
    Write-Host ""
    Write-Host "Command: " $AdobeUninstaller $ccRoboHelp11Params
    Write-Host ""
    Start-Process -FilePath $AdobeUninstaller -ArgumentList $ccRoboHelp11Params -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe ccRoboHelp 11 uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe ccRoboHelp 11 not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
