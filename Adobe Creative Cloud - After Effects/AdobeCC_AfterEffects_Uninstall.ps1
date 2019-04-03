<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe After Effects Creative Cloud 

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe After Effects CC

    .NOTES
      FileName: AdobeCC_AfterEffects_Uninstall.ps1
      Author: Jerry Senff
      Updated: 12/11/2016
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_AfterEffects_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_AfterEffects_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe After Effects Creative Cloud
$ccAfterEffects = "Adobe After Effects Creative Cloud"; 
$ccAfterEffectsUninstall = '"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"'
$ccAfterEffectsParams = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{317243C1-6580-4F43-AED7-37D4438C3DD5}"'
$ccAfterEffectsRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{317243C1-6580-4F43-AED7-37D4438C3DD5}'

Write-Host ""
Write-Host "******************************************************************"
Write-Host ""
Write-Host "$ccAfterEffects Uninstall"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "       - $ccAfterEffects"
Write-Host ""
 
# Uninstall Adobe After Effects Creative Cloud
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $ccAfterEffects installation..."
Write-Host ""
 
If ((Test-Path -Path $ccAfterEffectsRegkey) -eq 'True')
{
    Write-Host "    $ccAfterEffects is installed."
    Write-Host ""
    Write-Host "Uninstalling $ccAfterEffects..."
    Write-Host ""
    Write-Host "Command: " $ccAfterEffectsUninstall $ccAfterEffectsParams
    Write-Host ""
    Start-Process -FilePath $ccAfterEffectsUninstall -ArgumentList $ccAfterEffectsParams -ErrorVariable +err -Verb Open -Wait
    Write-Host "" 
    Write-Host "    $ccAfterEffects uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $ccAfterEffects not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
