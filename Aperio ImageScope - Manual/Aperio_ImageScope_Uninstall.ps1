<#
    .SYNOPSIS
      SCCM Uninstall program for Aperio ImageScope

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Aperio ImageScope
        - AperioPrerequisites

    .NOTES
      FileName: Aperio_ImageScope_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/28/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Aperio_ImageScope_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Aperio_ImageScope_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Aperio ImageScope
$MsiExec = (${env:SystemRoot} + '\System32\msiexec.exe')
$ImageScope= 'Aperio ImageScope'
$ImageScopeUninstall = '"' + ${env:ProgramFiles(x86)} + '\InstallShield Installation Information\{A5856584-F090-4FD3-BA95-34E6D85546B1}\setup.exe"'
$ImageScopeParams = '-runfromtemp -l0x0409  -removeonly'
$ImageScopeRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{A5856584-F090-4FD3-BA95-34E6D85546B1}'
 
# Uninstall variables - AperioPrerequisites
$AperioPrereq = 'AperioPrerequisites'
$AperioPrereqParams = '/x {07138E24-FE31-4AB3-BA41-36A56CDE2815} /qn /norestart'
$AperioPrereqRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{07138E24-FE31-4AB3-BA41-36A56CDE2815}'
 
Write-Host ""
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "$ImageScope Uninstaller"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - Uninstall $ImageScope"
Write-Host "         - Uninstall $AperioPrereq"
Write-Host ""
 
# Uninstall Aperio ImageScope
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $ImageScope installation..."
Write-Host ""
 
If ((Test-Path -Path $ImageScopeRegkey) -eq 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $ImageScope is installed."
    Write-Host ""
    Write-Host "Uninstalling $ImageScope..."
    Write-Host ""
    Write-Host "Command:  $ImageScopeUninstall $ImageScopeParams"
    Write-Host ""
    Start-Process -FilePath $ImageScopeUninstall -ArgumentList $ImageScopeParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $ImageScope uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $ImageScope is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
# Uninstall AperioPrerequisites
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $AperioPrereq installation..."
Write-Host ""
 
If ((Test-Path -Path $AperioPrereqRegkey) -eq 'True')
{
    Write-Host "    $AperioPrereq is installed."
    Write-Host ""
    Write-Host "Uninstalling $AperioPrereq..."
    Write-Host ""
    Write-Host "Command:  $MsiExec $AperioPrereqParams"
    Write-Host ""
    Start-Process -FilePath $MsiExec -ArgumentList $AperioPrereqParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $AperioPrereq uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $AperioPrereq not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
