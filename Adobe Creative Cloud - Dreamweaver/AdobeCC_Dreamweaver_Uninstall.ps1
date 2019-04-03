<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe Dreamweaver Creative Cloud

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe Dreamweaver CC

    .NOTES
      FileName: AdobeCC_Dreamweaver_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/25/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_Dreamweaver_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_Dreamweaver_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe Dreamweaver Creative Cloud
$AdobeUninstaller = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"')
$ccDreamweaverParams = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{00E094E1-A852-11E2-803D-ACEA632352B4}"'
$ccDreamweaverRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{00E094E1-A852-11E2-803D-ACEA632352B4}'
 
Write-Host ""
Write-Host "******** Adobe ccDreamweaver Uninstaller ********************************"
Write-Host ""
Write-Host "Purpose: Uninstall Adobe ccDreamweaver"
Write-Host ""
 
# Uninstall Adobe ccDreamweaver
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe ccDreamweaver installation...*"
Write-Host ""
 
If ((Test-Path -Path $ccDreamweaverRegkey) -eq 'True')
{
    Write-Host "    Adobe ccDreamweaver is installed."
    Write-Host ""
    Write-Host ""
    Write-Host "Uninstalling Adobe ccDreamweaver..."
    Write-Host ""
    Write-Host "Command: " $AdobeUninstaller $ccDreamweaverParams
    Write-Host ""
    Start-Process -FilePath $AdobeUninstaller -ArgumentList $ccDreamweaverParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe ccDreamweaver uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe ccDreamweaver not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
