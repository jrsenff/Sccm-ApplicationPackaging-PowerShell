<#
    .SYNOPSIS
      SCCM Install program for Adobe Dreamweaver CS6

    .DESCRIPTION
      Install the following component(s) on Window 7 x64 systems:
        - Adobe Dreamweaver CS6

    .NOTES
      FileName: Adobe_DreamweaverCS6_Install.ps1
      Author: Jerry Senff
      Updated: 02/26/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Adobe_DreamweaverCS6_Install.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Adobe_DreamweaverCS6_Install.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Install variables - Adobe Dreamweaver CS6
$AppName1 = 'Adobe Dreamweaver CS6'
$DreamweaverInstall = (${env:SystemRoot} + '\System32\msiexec.exe')
$DreamweaverParams = '/i "AdobeDreamweaverCS6.msi" /qb /norestart'
$DreamweaverRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{A4ED5E53-7AA0-11E1-BF04-B2D4D4A5360E}'
 
Write-Host ""
Write-Host "*************** Adobe Dreamweaver CS6 Installer ****************************"
Write-Host ""
 
#  Install Adobe Dreamweaver CS6
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $AppName1 installation..."
Write-Host ""
 
If ((Test-Path -Path $DreamweaverRegkey) -ne 'True')
{
    Write-Host "    $AppName1 is not installed."
    Write-Host ""
    Write-Host "Installing $AppName1..."
    Write-Host ""
    Write-Host "Command: " $DreamweaverInstall $DreamweaverParams
    Start-Process -FilePath $DreamweaverInstall -ArgumentList $DreamweaverParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $AppName1 install complete."
    Write-Host ""
}
Else
{
    Write-Host "    $AppName1 already installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
