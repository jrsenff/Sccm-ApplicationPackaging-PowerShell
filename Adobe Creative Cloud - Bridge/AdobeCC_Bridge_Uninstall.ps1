<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe Bridge Creative Cloud (64 Bit) 

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe Bridge CC (64 Bit)

    .NOTES
      FileName: AdobeCC_Bridge_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/25/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_Bridge_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_Bridge_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe Bridge Creative Cloud
$AdobeUninstaller = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"')
$ccBridgeParams = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{359F8007-6486-429C-A8C5-D67F6897C88C}"'
$ccBridgeRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{359F8007-6486-429C-A8C5-D67F6897C88C}'
 
Write-Host ""
Write-Host "******** Adobe CC Bridge Uninstaller ********************************"
Write-Host ""
Write-Host "Purpose: Uninstall Adobe ccBridge"
Write-Host ""
 
# Uninstall Adobe ccBridge
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe ccBridge installation...*"
Write-Host ""
 
If ((Test-Path -Path $ccBridgeRegkey) -eq 'True')
{
    Write-Host "    Adobe ccBridge is installed."
    Write-Host ""
    Write-Host "Uninstalling Adobe ccBridge..."
    Write-Host ""
    Write-Host "Command: " $AdobeUninstaller $ccBridgeParams
    Write-Host ""
    Start-Process -FilePath $AdobeUninstaller -ArgumentList $ccBridgeParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe ccBridge uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe ccBridge not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
