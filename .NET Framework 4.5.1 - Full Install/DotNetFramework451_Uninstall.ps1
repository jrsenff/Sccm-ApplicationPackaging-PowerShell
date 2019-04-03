<#
    .SYNOPSIS
      SCCM Uninstall program for .NET Framework 4.5.1 (64-bit) 

    .DESCRIPTION
      Removes the following components from Window 7 x64 systems:
        - Microsoft .NET Framework 4.5.1 (64-bit)

    .NOTES
      FileName: DotNetFramework451_Uninstall.ps1
      Author: Jerry Senff
      Updated: 12/07/2016
      Comments: Powershell.exe –executionpolicy bypass –file "DotNetFramework451_Uninstall.ps1"
#>

# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\DotNetFramework451_Uninstall.txt'  # MODIFY
$errFileLocation =  (${env:SystemDrive} + $errorpath)
 
# Uninstall Variables - Microsoft .NET Framework 4.5.1 (64-bit)
$dotNet451 = 'Microsoft .NET Framework 4.5.1'
$dotNet451Uninstall = '"' + ${env:windir} + '\Microsoft.NET\Framework64\v4.0.30319\SetupCache\v4.5.50938\setup.exe"'
$dotNet451Params = '/uninstall /x86 /x64 /q /norestart'
$dotNet451Regkey = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{92FB6C44-E685-45AD-9B20-CADF4CABA132} - 1033'

Write-Host ""
Write-Host "******************************************************************"
Write-Host ""
Write-Host "$dotNet451 Uninstall"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - $dotNet451"
Write-Host ""
 
# Uninstall Microsoft .NET Framework 4.5.1 (64-bit)
set-location $startLocation
Write-Host "********************************************************************"                  
Write-Host ""
Write-Host "Checking for $dotNet451 installation..."
Write-Host ""
 
If ((Test-Path -Path $dotNet451Regkey) -eq 'True')
{
    Write-Host "    $dotNet451 is installed."
    Write-Host ""
    Write-Host "Uninstalling $dotNet451..."
    Write-Host ""
    Write-Host "Command:  $dotNet451Uninstall $dotNet451Params"
    Write-Host ""
    Start-Process -FilePath $dotNet451Uninstall -ArgumentList $dotNet451Params -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $dotNet451 uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $dotNet451 not installed."
    Write-Host ""
}
 
Start-Sleep 5

# Indicate location of error log file
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
Write-Host ""
 
Start-Sleep 5
