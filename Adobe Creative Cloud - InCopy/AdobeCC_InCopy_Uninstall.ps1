<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe InCopy Creative Cloud

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe InCopy CC

    .NOTES
      FileName: AdobeCC_InCopy_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/26/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_InCopy_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_InCopy_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe InCopy Creative Cloud
$AdobeUninstaller = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"')
$ccInCopyParams = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{2606D96F-C1A3-1014-9A8F-E3561A1AC78D}"'
$ccInCopyRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{2606D96F-C1A3-1014-9A8F-E3561A1AC78D}'
 
Write-Host ""
Write-Host "******** Adobe ccInCopy Uninstaller ****************************************"
Write-Host ""
Write-Host "Purpose: Uninstall Adobe ccInCopy"
Write-Host ""
 
#              - Uninstalls Adobe ccInCopy                            #
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe ccInCopy installation...*"
Write-Host ""
 
If ((Test-Path -Path $ccInCopyRegkey) -eq 'True')
{
    Write-Host "    Adobe ccInCopy is installed."
    Write-Host ""
    Write-Host "Uninstalling Adobe ccInCopy..."
    Write-Host ""
    Write-Host "Command: " $AdobeUninstaller $ccInCopyParams
    Write-Host ""
    Start-Process -FilePath $AdobeUninstaller -ArgumentList $ccInCopyParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe ccInCopy uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe ccInCopy not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
