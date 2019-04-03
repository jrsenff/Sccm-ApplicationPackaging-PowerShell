<#
    .SYNOPSIS
      SCCM Uninstall program for Agilent IO Libraries

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Uninstall Agilent IO Libraries
        - Uninstall IVI Shared Components 
        - Uninstall VISA Shared Components 64-bit

    .NOTES
      FileName: Agilent_IO_Libraries_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/28/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Agilent_IO_Libraries_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Agilent_IO_Libraries_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Agilent IO Libraries
$AgilentLibraries = 'Agilent IO Libraries'
$AgilentLibrariesUninstall = '"' + ${env:ProgramFiles(x86)} + '\InstallShield Installation Information\{6419465C-004C-42D1-840D-3E23FA5D8E27}\setup.exe"'
$AgilentLibrariesParams = '-runfromtemp -l0x0409  -removeonly'
$AgilentLibrariesRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\InstallShield_{6419465C-004C-42D1-840D-3E23FA5D8E27}'
 
# Uninstall variables - Uninstall IVI Shared Components
$IviComponents = 'IVI Shared Components'
$IviComponentsUninstall = ${env:SystemRoot} + '\SysWOW64\CleanupUtility.exe'
$IviComponentsParams = '/fromARP'
$IviComponentsRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\IviSharedComponent'
 
# Uninstall variables - Uninstall VISA Shared Components 64-bit
$VisaComponents = 'VISA Shared Components 64-bit'
$VisaComponentsUninstall = ${env:SystemRoot} + '\SysWOW64\VISA_S~1.EXE'
$VisaComponentsParams = '/fromARP'
$VisaComponentsRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\VISASharedComponents'
 
Write-Host ""
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "$AgilentLibraries Uninstaller"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - Uninstall $AgilentLibraries"
Write-Host "         - Uninstall $IviComponents"
Write-Host "         - Uninstall $VisaComponents"
Write-Host ""
 
# Uninstall Agilent IO Libraries
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $AgilentLibraries installation..."
Write-Host ""
 
If ((Test-Path -Path $AgilentLibrariesRegkey) -eq 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $AgilentLibraries is installed."
    Write-Host ""
    Write-Host "Uninstalling $AgilentLibraries..."
    Write-Host ""
    Write-Host "Command:  $AgilentLibrariesUninstall $AgilentLibrariesParams"
    Write-Host ""
    Start-Process -FilePath $AgilentLibrariesUninstall -ArgumentList $AgilentLibrariesParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $AgilentLibraries uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $AgilentLibraries is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
# Uninstall IVI Shared Components
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $IviComponents installation..."
Write-Host ""
 
If ((Test-Path -Path $IviComponentsRegkey) -eq 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $IviComponents is installed."
    Write-Host ""
    Write-Host "Uninstalling $IviComponents..."
    Write-Host ""
    Write-Host "Command:  $IviComponentsUninstall $IviComponentsParams"
    Write-Host ""
    Start-Process -FilePath $IviComponentsUninstall -ArgumentList $IviComponentsParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $IviComponents uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $IviComponents is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
# Uninstall VISA Shared Components 64-bit 
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $VisaComponents installation..."
Write-Host ""
 
If ((Test-Path -Path $VisaComponentsRegkey) -eq 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $VisaComponents is installed."
    Write-Host ""
    Write-Host "Uninstalling $VisaComponents..."
    Write-Host ""
    Write-Host "Command:  $VisaComponentsUninstall $VisaComponentsParams"
    Write-Host ""
    Start-Process -FilePath $VisaComponentsUninstall -ArgumentList $VisaComponentsParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $VisaComponents uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $VisaComponents is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
