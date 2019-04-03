<#
    .SYNOPSIS
      SCCM Uninstall program for Autodesk Design Review 2013

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Autodesk Design Review 2013

    .NOTES
      FileName: Autodesk_Design_Review_2013_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/28/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Autodesk_Design_Review_2013_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Autodesk_Design_Review_2013_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Autodesk Design Review 2013
$Autodesk = 'Autodesk Design Review 2013' 
$AutodeskUninstall = (${env:ProgramFiles(x86)} + '\Autodesk\Autodesk Design Review 2013\Setup\Setup.exe')
$AutodeskParams = '/P {153DB567-6FF3-49AD-AC4F-86F8A3CCFDFB} /M ADR /language en-US'
$AutodeskRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Autodesk Design Review 2013'
 
Write-Host ""
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "$Autodesk Uninstaller"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - Uninstall $Autodesk"
Write-Host ""
 
# Uninstall Autodesk Design Review 2013
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $Autodesk installation..."
Write-Host ""
 
If ((Test-Path -Path $AutodeskRegkey) -eq 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $Autodesk is installed."
    Write-Host ""
    Write-Host "Uninstalling $Autodesk..."
    Write-Host ""
    Write-Host "Command:  $AutodeskUninstall $AutodeskParams"
    Write-Host ""
    Start-Process -FilePath $AutodeskUninstall -ArgumentList $AutodeskParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $Autodesk uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $Autodesk is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
