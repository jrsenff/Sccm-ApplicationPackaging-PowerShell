<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe Premiere Pro Creative Cloud

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe Premiere Pro CC

    .NOTES
      FileName: AdobeCC_PremierePro_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/26/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_PremierePro_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_PremierePro_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe Premiere Pro Creative Cloud
$AdobeUninstaller = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"')
$ccPremiereProParams = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{505FF1AC-E7F5-4462-BBA7-08900E7E9EEF}"'
$ccPremiereProRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{505FF1AC-E7F5-4462-BBA7-08900E7E9EEF}'
 
Write-Host ""
Write-Host "******** Adobe CC Premiere Pro Uninstaller ***********************************"
Write-Host ""
Write-Host "Purpose: Uninstall Adobe CC Premiere Pro"
Write-Host ""
 
# Uninstalls Adobe ccPremierePro
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe CC Premiere Pro installation...*"
Write-Host ""
 
If ((Test-Path -Path $ccPremiereProRegkey) -eq 'True')
{
    Write-Host "    Adobe ccPremiere Pro is installed."
    Write-Host ""
    Write-Host "Uninstalling Adobe CC Premiere Pro..."
    Write-Host ""
    Write-Host "Command: " $AdobeUninstaller $ccPremiereProParams
    Write-Host ""
    Start-Process -FilePath $AdobeUninstaller -ArgumentList $ccPremiereProParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe CC Premiere Pro uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe CC Premiere Pro not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
