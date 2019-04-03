<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe Dreamweaver CS6

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe Dreamweaver CS6

    .NOTES
      FileName: Adobe_DreamweaverCS6_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/26/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Adobe_DreamweaverCS6_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Adobe_DreamweaverCS6_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Update variables - Adobe Application Manager Enterprise 3.1
$AppName2 = 'Application Manager Enterprise 3.1'
$AppMgrUpdate = './AdobeAppMgrEnterprise3-1/Setup.exe'
$AppMgrParams = '--mode=silent --action=update'
 
# Uninstall variables - Adobe Dreamweaver CS6
$AppName1 = 'Adobe Dreamweaver CS6'
$DreamweaverPdapp = '/Common Files/Adobe/OOBE/PDApp/core/PDApp.exe'
$DreamweaverUninstall = (${env:ProgramFiles(x86)} + $DreamweaverPdapp)
$DreamweaverParams = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{A4ED5E53-7AA0-11E1-BF04-B2D4D4A5360E}"'
$DreamweaverRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{A4ED5E53-7AA0-11E1-BF04-B2D4D4A5360E}'
 
Write-Host ""
Write-Host "******** Adobe Dreamweaver CS6 Uninstaller *********************************"
Write-Host "        - Update the Adobe Application Manager"
Write-Host "        - Uninstall Dreamweaver CS6"
Write-Host ""
 
# Update Adobe Adobe Application Manager Enterprise 3.1
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Updating for $AppName2..."
Write-Host ""
Write-Host "Command: " $AppMgrUpdate $AppMgrParams
Write-Host ""
Start-Process -FilePath $AppMgrUpdate -ArgumentList $AppMgrParams -ErrorVariable +err -Verb Open -Wait 
Write-Host ""
Write-Host "    $AppName2 update complete."
Write-Host ""
 
sleep 10
 
# Uninstalls Adobe Dreamweaver CS6
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $AppName1 installation...*"
Write-Host ""
 
If ((Test-Path -Path $DreamweaverRegkey) -eq 'True')
{
    Write-Host "    $AppName1 is installed."
    Write-Host ""
    Write-Host "Uninstalling $AppName1..."
    Write-Host ""
    Write-Host "Command: " $DreamweaverUninstall $DreamweaverParams
    Write-Host ""
    Start-Process -FilePath $DreamweaverUninstall -ArgumentList $DreamweaverParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $AppName1 uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $AppName1 not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
