<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe Photoshop Creative Cloud

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe Photoshop CC

    .NOTES
      FileName: AdobeCC_Photoshop_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/26/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_Photoshop_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_Photoshop_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe Photoshop Creative Cloud
$AdobeUninstaller = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"')
$ccPhotoshopParams = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{2D99B50E-431D-4AA8-85C1-172A6F8BCF09}"'
$ccPhotoshopRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{2D99B50E-431D-4AA8-85C1-172A6F8BCF09}'
 
Write-Host ""
Write-Host "******** Adobe ccPhotoshop Uninstaller *************************************"
Write-Host ""
Write-Host "Purpose: Uninstall Adobe ccPhotoshop and component"
Write-Host ""
 
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe ccPhotoshop installation...*"
Write-Host ""
 
If ((Test-Path -Path $ccPhotoshopRegkey) -eq 'True')
{
    Write-Host "    Adobe ccPhotoshop is installed."
    Write-Host ""
    Write-Host "Uninstalling Adobe ccPhotoshop..."
    Write-Host ""
    Write-Host "Command: " $AdobeUninstaller $ccPhotoshopParams
    Write-Host ""
    Start-Process -FilePath $AdobeUninstaller -ArgumentList $ccPhotoshopParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe ccPhotoshop uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe ccPhotoshop not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
