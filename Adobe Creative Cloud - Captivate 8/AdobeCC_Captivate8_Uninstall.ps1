<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe Creative Cloud Captivate 8 (64 Bit) 

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe Captivate 8 (64 Bit)

    .NOTES
      FileName: AdobeCC_Captivate8_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/25/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_Captivate8_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_Captivate8_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe Captivate 8 Creative Cloud
$AdobeUninstaller = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"')
$ccCaptivate8Params = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{92397ACD-D9F9-11E3-B8F3-CE58971B0EB2}"'
$ccCaptivate8Regkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{92397ACD-D9F9-11E3-B8F3-CE58971B0EB2}'
 
Write-Host ""
Write-Host "******** Adobe ccCaptivate 8 Uninstaller ***********************************"
Write-Host ""
Write-Host "Purpose: Uninstall Adobe ccCaptivate 8"
Write-Host ""
 
# Uninstall Adobe ccCaptivate 8
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe ccCaptivate 8 installation...*"
Write-Host ""
 
If ((Test-Path -Path $ccCaptivate8Regkey) -eq 'True')
{
    Write-Host "    Adobe ccCaptivate 8 is installed."
    Write-Host ""
    Write-Host ""
    Write-Host "Uninstalling Adobe ccCaptivate 8..."
    Write-Host ""
    Write-Host "Command: " $AdobeUninstaller $ccCaptivate8Params
    Write-Host ""
    Start-Process -FilePath $AdobeUninstaller -ArgumentList $ccCaptivate8Params -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe ccCaptivate 8 uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe ccCaptivate 8 not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
