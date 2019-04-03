<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe Creative Cloud Captivate 7 (64 Bit) 

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe Captivate 7 (64 Bit)

    .NOTES
      FileName: AdobeCC_Captivate7_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/25/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_Captivate7_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_Captivate7_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe Captivate 7 Creative Cloud
$AdobeUninstaller = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"')
$ccCaptivateParams = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{E439BF4F-C244-11E2-B06C-C806F2D674D1}"'
$ccCaptivateRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{E439BF4F-C244-11E2-B06C-C806F2D674D1}'
 
Write-Host ""
Write-Host "******** Adobe CC Captivate Uninstaller ********************************"
Write-Host ""
Write-Host "Purpose: Uninstall Adobe CC Captivate"
Write-Host ""
 
# Uninstall Adobe ccCaptivate 7
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe ccCaptivate installation...*"
Write-Host ""
 
If ((Test-Path -Path $ccCaptivateRegkey) -eq 'True')
{
    Write-Host "    Adobe ccCaptivate is installed."
    Write-Host ""
    Write-Host ""
    Write-Host "Uninstalling Adobe ccCaptivate..."
    Write-Host ""
    Write-Host "Command: " $AdobeUninstaller $ccCaptivateParams
    Write-Host ""
    Start-Process -FilePath $AdobeUninstaller -ArgumentList $ccCaptivateParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe ccCaptivate uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe ccCaptivate not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
