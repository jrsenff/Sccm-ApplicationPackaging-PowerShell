<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe Fireworks Creative Cloud

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe Fireworks CC

    .NOTES
      FileName: AdobeCC_Fireworks_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/26/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_Fireworks_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_Fireworks_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe Fireworks Creative Cloud
$AdobeUninstaller = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"')
$ccFireworksParams = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{CA7C485C-7A89-11E1-B2C8-CD54B377BC52}"'
$ccFireworksRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{CA7C485C-7A89-11E1-B2C8-CD54B377BC52}'
 
Write-Host ""
Write-Host "******** Adobe ccFireworks Uninstaller *************************************"
Write-Host ""
Write-Host "Purpose: Uninstall Adobe ccFireworks and component"
Write-Host ""
 
# Uninstalls Adobe ccFireworks
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe ccFireworks installation...*"
Write-Host ""
 
If ((Test-Path -Path $ccFireworksRegkey) -eq 'True')
{
    Write-Host "    Adobe ccFireworks is installed."
    Write-Host ""
    Write-Host ""
    Write-Host "Uninstalling Adobe ccFireworks..."
    Write-Host ""
    Write-Host "Command: " $AdobeUninstaller $ccFireworksParams
    Write-Host ""
    Start-Process -FilePath $AdobeUninstaller -ArgumentList $ccFireworksParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe ccFireworks uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe ccFireworks not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
