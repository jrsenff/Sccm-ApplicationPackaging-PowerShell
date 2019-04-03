<#
    .SYNOPSIS
      SCCM Uninstall program for Axon MultiClamp 700B Commander

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Axon MultiClamp 700B Commander

    .NOTES
      FileName: Axon_MutiClamp_Commander_700B_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/28/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Axon_MutiClamp_Commander_700B_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Axon_MutiClamp_Commander_700B_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Axon MultiClamp 700B Commander
$MultiClamp = 'Axon MultiClamp 700B Commander'
$MultiClampUninstall = '"' + ${env:ProgramData} + '\{16AC0882-43C3-4284-870D-5E3453E2555F}\MultiClamp.exe"'
$MultiClampParams = 'REMOVE=TRUE MODIFY=FALSE'
$MultiClampRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\MultiClamp 700B Commander Software'
 
Write-Host ""
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "$MultiClamp Uninstaller"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - Uninstall $MultiClamp"
Write-Host ""
 
# Uninstall Axon MultiClamp 700B Commander
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $MultiClamp installation..."
Write-Host ""
 
If ((Test-Path -Path $MultiClampRegkey) -eq 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $MultiClamp is installed."
    Write-Host ""
    Write-Host "Uninstalling $MultiClamp..."
    Write-Host ""
    Write-Host "Command:  $MultiClampUninstall $MultiClampParams"
    Write-Host ""
    Start-Process -FilePath $MultiClampUninstall -ArgumentList $MultiClampParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $MultiClamp uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $MultiClamp is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
