<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe Flash Professional Creative Cloud

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe Flash Professional CC

    .NOTES
      FileName: AdobeCC_FlashProfessional_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/26/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_FlashProfessional_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_FlashProfessional_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe Flash Professional Creative Cloud
$AdobeUninstaller = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"')
$ccFlashProParams = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{B56B95BF-7161-4166-8288-DB1BA9F6C9B8}"'
$ccFlashProRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{B56B95BF-7161-4166-8288-DB1BA9F6C9B8}'
 
Write-Host ""
Write-Host "******** Adobe ccFlashPro Uninstaller **************************************"
Write-Host ""
Write-Host "Purpose: Uninstall Adobe ccFlashPro"
Write-Host ""
 
# Uninstall Adobe ccFlashPro
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe ccFlashPro installation...*"
Write-Host ""
 
If ((Test-Path -Path $ccFlashProRegkey) -eq 'True')
{
    Write-Host "    Adobe ccFlashPro is installed."
    Write-Host ""
    Write-Host "Uninstalling Adobe ccFlashPro..."
    Write-Host ""
    Write-Host "Command: " $AdobeUninstaller $ccFlashProParams
    Write-Host ""
    Start-Process -FilePath $AdobeUninstaller -ArgumentList $ccFlashProParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe ccFlashPro uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe ccFlashPro not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
