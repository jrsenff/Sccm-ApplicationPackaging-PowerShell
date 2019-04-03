<#
    .SYNOPSIS
      SCCM Uninstall program for removing all of 4Media DVD Ripper Ultimate 6 (32-bit) 

    .DESCRIPTION
      Removes the following component(s) from Window 7 x64 systems:
        - 4Media DVD Ripper Ultimate 6

    .NOTES
      FileName: 4MediaDvdRipperUltimate6-Uninstall.ps1
      Author: Jerry Senff
      Updated: 12/06/2016
      Comments: Powershell.exe –executionpolicy bypass –file "4MediaDvdRipperUltimate6_Uninstall"
#>
 
# Uninstall Variables - 4Media DVD Ripper Ultimate 6
$4Media = '4Media DVD Ripper Ultimate 6'
$4MediaUninstall = '"' + ${env:ProgramFiles(x86)} + '\4Media\DVD Ripper Ultimate 6\Uninstall.exe"'
$4MediaRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\4Media DVD Ripper Ultimate 6'
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\4MediaDvdRipperUltimate6_Uninstall.txt'  # MODIFY
$errFileLocation =  (${env:SystemDrive} + $errorpath)

Write-Host ""
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "$4Media Uninstaller"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - Uninstall $4Media"
Write-Host ""
 
# Uninstall 4Media DVD Ripper Ultimate 6
#          - Uninstall 4Media DVD Ripper                                #
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $4Media installation..."
Write-Host ""
 
If ((Test-Path -Path $4MediaRegkey) -eq 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $4Media is installed."
    Write-Host ""
    Write-Host "Uninstalling $4Media..."
    Write-Host ""
    Write-Host "Command:  $4MediaUninstall"
    Write-Host ""
    Start-Process -FilePath $4MediaUninstall -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $4Media uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $4Media is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
