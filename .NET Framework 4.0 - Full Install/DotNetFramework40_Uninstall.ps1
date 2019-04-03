<#
    .SYNOPSIS
      SCCM Uninstall program for .NET Framework 4 Full (64-bit) 

    .DESCRIPTION
      Removes the following components from Window 7 x64 systems:
        - Microsoft .NET Framework 4 Client Profile (64-bit)
        - Microsoft .NET Framework 4 Extended (64-bit)

    .NOTES
      FileName: DotNetFramework40_Uninstall.ps1
      Author: Jerry Senff
      Updated: 12/07/2016
      Comments: Powershell.exe –executionpolicy bypass –file "DotNetFramework40_Uninstall.ps1"
#>

# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\DotNetFramework40.txt'  # MODIFY
$errFileLocation =  (${env:SystemDrive} + $errorpath)

$dotNet4 = "Microsoft .NET Framework 4"

# Uninstall Variables - Microsoft .NET Framework 4 Extended (64-bit)
$dotNet4Extended = 'Microsoft .NET Framework 4 Extended'
$dotNet4ExtendedUninstall = '"' + ${env:windir} + '\Microsoft.NET\Framework64\v4.0.30319\SetupCache\Extended\setup.exe"'
$dotNet4ExtendedParams = '/uninstall /x86 /x64 /ia64 /parameterfolder Extended /q /norestart'
$dotNet4ExtendedRegkey = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{8E34682C-8118-31F1-BC4C-98CD9675E1C2}'

# Uninstall Variables - Microsoft .NET Framework 4 Client Profile (64-bit)
$dotNet4Client = 'Microsoft .NET Framework 4 Client Profile'
$dotNet4ClientUninstall = '"' + ${env:windir} + '\Microsoft.NET\Framework64\v4.0.30319\SetupCache\Client\setup.exe"'
$dotNet4ClientParams = '/uninstall /x86 /x64 /parameterfolder Client /q /norestart'
$dotNet4ClientRegkey = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{F5B09CFD-F0B2-36AF-8DF4-1DF6B63FC7B4}'
 
Write-Host ""
Write-Host "******************************************************************"
Write-Host ""
Write-Host "$dotNet4 Uninstall"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - $dotNet4Extended"
Write-Host "         - $dotNet4Client"
Write-Host ""
 
# Uninstall Microsoft .NET Framework 4 Extended (64-bit)
set-location $startLocation
Write-Host "********************************************************************"                  
Write-Host ""
Write-Host "Checking for $dotNet4Extended installation..."
Write-Host ""
 
If ((Test-Path -Path $dotNet4ExtendedRegkey) -eq 'True')
{
    Write-Host "    $dotNet4Extended is installed."
    Write-Host ""
    Write-Host "Uninstalling $dotNet4Extended..."
    Write-Host ""
    Write-Host "Command:  $dotNet4ExtendedUninstall $dotNet4ExtendedParams"
    Write-Host ""
    Start-Process -FilePath $dotNet4ExtendedUninstall -ArgumentList $dotNet4ExtendedParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $dotNet4Extended uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $dotNet4Extended not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
# Uninstall Microsoft .NET Framework 4 Client Profile (64-bit)
set-location $startLocation
Write-Host "********************************************************************"                  
Write-Host ""
Write-Host "Checking for $dotNet4Client installation..."
Write-Host ""
 
If ((Test-Path -Path $dotNet4ClientRegkey) -eq 'True')
{
    Write-Host "    $dotNet4Client is installed."
    Write-Host ""
    Write-Host "Uninstalling $dotNet4Client..."
    Write-Host ""
    Write-Host "Command:  $dotNet4ClientUninstall $dotNet4ClientParams"
    Write-Host ""
    Start-Process -FilePath $dotNet4ClientUninstall -ArgumentList $dotNet4ClientParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $dotNet4Client uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $dotNet4Client not installed."
    Write-Host ""
}

Start-Sleep 5

# Indicate location of error log file
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
Write-Host ""
 
Start-Sleep 5
