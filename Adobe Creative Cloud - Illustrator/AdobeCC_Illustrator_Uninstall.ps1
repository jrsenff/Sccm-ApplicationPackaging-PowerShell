<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe Illustrator Creative Cloud

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe Illustrator CC

    .NOTES
      FileName: AdobeCC_Illustrator_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/26/2019
      Comments: Powershell.exe –executionpolicy bypass –file "AdobeCC_Illustrator_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AdobeCC_Illustrator_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Adobe Illustrator Creative Cloud
$AdobeUninstaller = ('"' + ${env:ProgramFiles(x86)} + '\Common Files\Adobe\OOBE\PDApp\core\PDApp.exe"')
$ccIllustratorParams = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{F2321021-08A2-44D6-B1DF-BDB415F23EC3}"'
$ccIllustratorRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{F2321021-08A2-44D6-B1DF-BDB415F23EC3}'
 
Write-Host ""
Write-Host "******** Adobe ccIllustrator Uninstaller ***********************************"
Write-Host ""
Write-Host "Purpose: Uninstall Adobe ccIllustrator"
Write-Host ""
 
#              - Uninstalls Adobe ccIllustrator                       #
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe ccIllustrator installation...*"
Write-Host ""
 
If ((Test-Path -Path $ccIllustratorRegkey) -eq 'True')
{
    Write-Host "    Adobe ccIllustrator is installed."
    Write-Host ""
    Write-Host "Uninstalling Adobe ccIllustrator..."
    Write-Host ""
    Write-Host "Command: " $AdobeUninstaller $ccIllustratorParams
    Write-Host ""
    Start-Process -FilePath $AdobeUninstaller -ArgumentList $ccIllustratorParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe ccIllustrator uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe ccIllustrator not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
