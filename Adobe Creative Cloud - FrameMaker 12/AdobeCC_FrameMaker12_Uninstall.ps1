<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe FrameMaker 12 Creative Cloud

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe FrameMaker 12

    .NOTES
      FileName: AdobeCC_FrameMaker12_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/26/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_FrameMaker12_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_FrameMaker12_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe FrameMaker 12 Creative Cloud
$AdobeUninstaller = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"')
$ccFramemaker12Params = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{065D7F9D-77A5-4A65-9CFB-59C1C776C7D9}"'
$ccFramemaker12Regkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{065D7F9D-77A5-4A65-9CFB-59C1C776C7D9}'
 
Write-Host ""
Write-Host "******** Adobe ccFrameMaker 12 Uninstaller *********************************"
Write-Host ""
Write-Host "Purpose: Uninstall Adobe ccFrameMaker 12"
Write-Host ""
 
# Uninstalls Adobe ccFrameMaker 12
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe ccFrameMaker 12 installation...*"
Write-Host ""
 
If ((Test-Path -Path $ccFramemaker12Regkey) -eq 'True')
{
    Write-Host "    Adobe ccFrameMaker 12 is installed."
    Write-Host ""
    Write-Host "Uninstalling Adobe ccFrameMaker 12..."
    Write-Host ""
    Write-Host "Command: " $AdobeUninstaller $ccFramemaker12Params
    Write-Host ""
    Start-Process -FilePath $AdobeUninstaller -ArgumentList $ccFramemaker12Params -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe ccFrameMaker 12 uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe ccFrameMaker 12 not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
