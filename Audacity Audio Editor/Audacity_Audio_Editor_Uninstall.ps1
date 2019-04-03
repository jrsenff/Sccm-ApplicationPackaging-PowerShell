<#
    .SYNOPSIS
      SCCM Uninstall program for Audacity Audio Editor

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Audacity Audio Editor

    .NOTES
      FileName: Audacity_Audio_Editor_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/28/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Audacity_Audio_Editor_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Audacity_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Audacity Audio Editor
$Audacity = 'Audacity Audio Editor'
$AudacityUninstall = '"' + ${env:ProgramFiles(x86)} + '\Audacity\unins000.exe"'
$AudacityParams = '/SILENT'
$AudacityRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Audacity_is1'
 
Write-Host ""
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "$Audacity Uninstaller"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - Uninstall $Audacity"
Write-Host ""
 
# Uninstall Audacity Audio Editor
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $Audacity installation..."
Write-Host ""
 
If ((Test-Path -Path $AudacityRegkey) -eq 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $Audacity is installed."
    Write-Host ""
    Write-Host "Uninstalling $Audacity..."
    Write-Host ""
    Write-Host "Command:  $AudacityUninstall $AudacityParams"
    Write-Host ""
    Start-Process -FilePath $AudacityUninstall -ArgumentList $AudacityParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $Audacity uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $Audacity is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
