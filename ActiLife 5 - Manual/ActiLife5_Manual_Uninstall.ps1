<#
    .SYNOPSIS
      SCCM Uninstall program for ActiLife5 (32-bit) 

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - ActiLife5
        - ActiGraph USB Device drivers
        - MS Chart Controls for MS .NET Framework 3.5
        - MS Chart Controls for MS .NET Framework 3.5 Uninstall regkey
        - ActiLife5 Program Files (x86) folder
        - ActiLife5 Start Menu folder

    .NOTES
      FileName: ActiLife5_Manual_Uninstall.ps1
      Author: Jerry Senff
      Updated: 12/08/2016
      Comments: Powershell.exe –executionpolicy bypass –file "ActiLife5_Manual_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\ActiLife5_Manual_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - ActiLife5 
$ActiLife5 = 'ActiLife5'
$ActiLife5Uninstall = ${env:ProgramFiles(x86)} + '\ActiGraph\ActiLife5\uninst.exe'
$ActiLife5Regkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\ActiLife5'
$ActiLife5InstallFolder = ${env:ProgramFiles(x86)} + '\ActiGraph\ActiLife5'
$ActiLife5StartMenuFolder = ${env:ProgramData} + 'Microsoft\Windows\Start Menu\Programs\ActiGraph\ActiLife5'

# Uninstall variables - ActiGraph USB Device 
$ActiGraphUsbDev = 'ActiGraph USB Device'
$ActiGraphUsbDevUninstall = ${env:windir} + '\system32\Silabs\DriverUninstaller.exe'
$ActiGraphUsbDevParams = 'USBXpress\ACTIGRAPHDRIVERS&167F&5055'
$ActiGraphUsbDevRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\ACTIGRAPHDRIVERS&167F&5055'

# Uninstall variables - MS Chart Controls for MS .NET Framework 3.5
$Chart = 'MS Chart Controls for MS .NET Framework 3.5'
$MsiExec = ${env:SystemRoot} + '\System32\msiexec.exe'
$ChartParams = '/X {41785C66-90F2-40CE-8CB5-1C94BFC97280} /qb /norestart'
$ChartRegKey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{41785C66-90F2-40CE-8CB5-1C94BFC97280}'
 
Write-Host ""
Write-Host "******************************************************************"
Write-Host ""
Write-Host "$ActiLife5 Uninstall"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "       - $ActiLife5"
Write-Host "       - $ActiGraphUsbDev"
Write-Host "       - $Chart"
Write-Host "       - $Chart Uninstall registry key"
Write-Host "       - $ActiLife5 Program Files (x86) folder"
Write-Host "       - $ActiLife5 Start Menu folder"
Write-Host ""
 
# Uninstall ActiLife5
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $ActiLife5 installation..."
Write-Host ""
 
If ((Test-Path -Path $ActiLife5Regkey) -eq 'True')
{
    Write-Host "    $ActiLife5 is installed."
    Write-Host ""
    Write-Host "Uninstalling $ActiLife5..."
    Write-Host ""
    Write-Host "Command: " $ActiLife5Uninstall
    Write-Host ""
    Start-Process -FilePath $ActiLife5Uninstall -ErrorVariable +err -Verb Open -Wait
    Write-Host "" 
    Write-Host "    $ActiLife5 uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $ActiLife5 not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
# Uninstall ActiGraph USB Device drivers
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $ActiGraphUsbDev installation..."
Write-Host ""
 
If ((Test-Path -Path $ActiGraphUsbDevRegkey) -eq 'True')
{
    Write-Host "    $ActiGraphUsbDev is installed."
    Write-Host ""
    Write-Host "Uninstalling $ActiGraphUsbDev..."
    Write-Host ""
    Write-Host "Command:  $ActiGraphUsbDevUninstall $ActiGraphUsbDevParams"
    Write-Host ""
    Start-Process -FilePath $ActiGraphUsbDevUninstall -ArgumentList $ActiGraphUsbDevParams -ErrorVariable +err -Verb Open -Wait
    Write-Host "" 
    Write-Host "     $ActiGraphUsbDev uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $ActiGraphUsbDev not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
# Remove MS Chart Controls for MS .NET Framework 3.5
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $Chart installation..."
Write-Host ""
 
If ((Test-Path -Path $ChartRegKey) -eq 'True')
{
    Write-Host "    $Chart is installed."
    Write-Host ""
    Write-Host "Uninstalling $Chart..."
    Write-Host ""
    Write-Host "Command: " $MsiExec $ChartParams
    Write-Host ""
    Start-Process -FilePath $MsiExec -ArgumentList $ChartParams -ErrorVariable +err -Verb Open -Wait
    Write-Host "" 
    Write-Host "    $Chart uninstall complete."
    Write-Host ""
    Write-Host "Checking for $Chart Uninstall registry key..."
    Write-Host ""

    # Delete MS Chart Controls Uninstall regkey
    if ((Test-Path -Path $ChartRegKey) -eq 'True')
    {
        Write-Host "    $Chart Uninstall registry key exists."
        Write-Host ""
        Write-Host "Deleting $Chart Uninstall registry key..."
        Write-Host ""
        Write-Host "Command: Remove-Item -Path $ChartRegKey -Recurse -Force"
        Write-Host ""
        Remove-Item -Path $ChartRegKey -Recurse -Force
        Write-Host ""
        Write-Host "    $Chart uninstall registry key removal complete."
        Write-Host ""
    }
    else
    {
        Write-Host "    $Chart Uninstall registry key does not exist."
        Write-Host ""
    }
}
Else
{
    Write-Host "    $Chart not installed."
    Write-Host ""
}
 
Start-Sleep 5

# Delete ActiLife5 Program Files (x86) folder
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $ActiLife5 Program Files (x86) folder..."
Write-Host ""
if ((Test-Path -Path $ActiLife5InstallFolder) -eq 'True')
{
    Write-Host "    $ActiLife5 install folder exists."
    Write-Host ""
    Write-Host "    Location $ActiLife5InstallFolder"
    Write-Host ""
    Write-Host "Deleting $ActiLife5 install folder..."
    Write-Host ""
    Write-Host "Command:  Remove-Item -Path $ActiLife5InstallFolder -Recurse -Force"
    Write-Host ""
    Remove-Item -Path $ActiLife5InstallFolder -Recurse -Force
    Write-Host "" 
    Write-Host "    $ActiLife5 install folder deleted."
    Write-Host ""
}
Else
{
    Write-Host "    $ActiLife5 install folder does not exist."
    Write-Host ""
}
 
Start-Sleep 5
 
# Delete ActiLife5 Start Menu folder
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $ActiLife5 Start Menu folder..."
Write-Host ""
if ((Test-Path -Path $ActiLife5StartMenuFolder) -eq 'True')
{
    Write-Host "    $ActiLife5 Start Menu folder exists."
    Write-Host ""
    Write-Host "    Location $ActiLife5StartMenuFolder"
    Write-Host ""
    Write-Host "Deleting $ActiLife5 Start Menu folder..."
    Write-Host ""
    Write-Host "Command:  Remove-Item -Path $ActiLife5StartMenuFolder -Recurse -Force"
    Write-Host ""
    Remove-Item -Path $ActiLife5StartMenuFolder -Recurse -Force
    Write-Host "" 
    Write-Host "    $ActiLife5 Start Menu folder deleted."
    Write-Host ""
}
Else
{
    Write-Host "    $ActiLife5 Start Menu folder does not exist."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = $errFileLocation ***"
 
Start-Sleep 5
