<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe InDesign Creative Cloud

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe InDesign CC

    .NOTES
      FileName: AdobeCC_InDesign_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/26/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_InDesign_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_InDesign_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe InDesign Creative Cloud
$AdobeUninstaller = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"')
$ccInDesignParams = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{BC448016-6F11-1014-B0EA-97CEE6E26CB6}"'
$ccInDesignRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{BC448016-6F11-1014-B0EA-97CEE6E26CB6}'
 
Write-Host ""
Write-Host "******** Adobe ccInDesign Uninstaller **************************************"
Write-Host ""
Write-Host "Purpose: Uninstall Adobe ccInDesign and component"
Write-Host ""
 
#              - Uninstalls Adobe ccInDesign                          #
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe ccInDesign installation...*"
Write-Host ""
 
If ((Test-Path -Path $ccInDesignRegkey) -eq 'True')
{
    Write-Host "    Adobe ccInDesign is installed."
    Write-Host ""
    Write-Host "Uninstalling Adobe ccInDesign..."
    Write-Host ""
    Write-Host "Command: " $AdobeUninstaller $ccInDesignParams
    Write-Host ""
    Start-Process -FilePath $AdobeUninstaller -ArgumentList $ccInDesignParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe ccInDesign uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe ccInDesign not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
