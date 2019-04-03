<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe Presenter Creative Cloud

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe Presenter 9.0

    .NOTES
      FileName: AdobeCC_Presenter_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/26/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_Presenter_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_Presenter_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe Presenter Creative Cloud
$AdobeUninstaller = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"')
$ccPresenterParams = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{AABAC03B-D6A3-11E2-B4B8-922E8DCBB854}"'
$ccPresenterRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{AABAC03B-D6A3-11E2-B4B8-922E8DCBB854}'
 
Write-Host ""
Write-Host "******** Adobe ccPresenter Uninstaller *************************************"
Write-Host ""
Write-Host "Purpose: Uninstall Adobe ccPresenter"
Write-Host ""
 
# Uninstalls Adobe ccPresenter
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe ccPresenter installation...*"
Write-Host ""
 
If ((Test-Path -Path $ccPresenterRegkey) -eq 'True')
{
    Write-Host "    Adobe ccPresenter is installed."
    Write-Host ""
    Write-Host "Uninstalling Adobe ccPresenter..."
    Write-Host ""
    Write-Host "Command: " $AdobeUninstaller $ccPresenterParams
    Write-Host ""
    Start-Process -FilePath $AdobeUninstaller -ArgumentList $ccPresenterParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe ccPresenter uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe ccPresenter not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
