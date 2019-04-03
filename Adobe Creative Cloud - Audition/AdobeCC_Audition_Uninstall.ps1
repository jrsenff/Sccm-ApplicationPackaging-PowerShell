<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe Audition Creative Cloud 

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe Audition CC

    .NOTES
      FileName: AdobeCC_Audition_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/25/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_Audition_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_Audition_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe Audition Creative Cloud
$AdobeUninstaller = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"')
$ccAuditionParams = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{DE1E055B-679C-42F8-B114-7B6ED0B8ED95}"'
$ccAuditionRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{DE1E055B-679C-42F8-B114-7B6ED0B8ED95}'
 
Write-Host ""
Write-Host "******** Adobe CC Audition Uninstaller **************************************"
Write-Host ""
Write-Host "Purpose: Uninstall Adobe CC Audition"
Write-Host ""
 
#              - Uninstall Adobe ccAudition                           #
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe ccAudition installation...*"
Write-Host ""
 
If ((Test-Path -Path $ccAuditionRegkey) -eq 'True')
{
    Write-Host "    Adobe ccAudition is installed."
    Write-Host ""
    Write-Host ""
    Write-Host "Uninstalling Adobe ccAudition..."
    Write-Host ""
    Write-Host "Command: " $AdobeUninstaller $ccAuditionParams
    Write-Host ""
    Start-Process -FilePath $AdobeUninstaller -ArgumentList $ccAuditionParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe ccAudition uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe ccAudition not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
