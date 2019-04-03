<#
    .SYNOPSIS
      SCCM Uninstall program for ActiLife 6 (32-bit) 

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - ActiLife 6
        - ActiGraph USB Device drivers
        - Windows Driver Package - Dynastream Innov.
        - Windows Driver Package - ActiGraph (WinUSB)
        - MS Chart Controls for MS .NET Framework 3.5
        - MS Chart Controls for MS .NET Framework 3.5 Uninstall regkey
        - ActiLife 6 Program Files folder
        - ActiLife 6 Program Files (x86) folder
        - ActiLife 6 Start Menu folder

    .NOTES
      FileName: ActiLife6_Manual_Uninstall.ps1
      Author: Jerry Senff
      Updated: 12/08/2016
      Comments: Powershell.exe –executionpolicy bypass –file "ActiLife6_Manual_Uninstall.ps1"
#>

# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\ActiLife6_Manual_Uninstall_error_log.txt'
$errFileLocation = ${env:SystemDrive} + $errorpath

# Uninstall variables - ActiLife 6
$ActiLife6 = 'ActiLife 6.10.2'
$ActiLife6Uninstall = ${env:ProgramFiles(x86)} + '\ActiGraph\ActiLife6\uninst.exe'
$ActiLife6Regkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\ActiLife'

# Uninstall variables - ActiGraph USB Device drivers
$ActiGraphUsbDev = 'ActiGraph USB Device'
$ActiGraphUsbDevUninstall = ${env:ProgramFiles} + '\ActiGraph\Drivers\DriverUninstaller.exe'
$ActiGraphUsbDevParams = '"USBXpress\ACTIGRAPHDRIVERS&167F&5055"'
$ActiGraphUsbDevRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\ACTIGRAPHDRIVERS&167F&5055'

# Uninstall variables - Windows Driver Package - Dynastream Innov.
$Dynastream = 'Windows Driver Package - Dynastream Innov.'
$DynastreamUninstall = '"' + ${env:ProgramFiles} + '\DIFX\0169CE3A95F06636\dpinst64.exe"'
$DynastreamParams = '/u "' + ${env:SystemRoot} + '\System32\DriverStore\FileRepository\ant_libusb.inf_amd64_neutral_54173307afc55815\ant_libusb.inf"'
$DynastreamRegkey = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\F9D2A789F9CFF8CEC36B544F53877C80F1F73C46'

# Uninstall variables - Windows Driver Package - ActiGraph (WinUSB)
$ActiGraph = 'Windows Driver Package - ActiGraph (WinUSB)'
$ActiGraphWinUsbUninstall = '"' + ${env:ProgramFiles} + '\DIFX\0169CE3A95F06636\dpinst64.exe"'
$ActiGraphWinUsbParams = '/u "' + ${env:SystemRoot} + '\System32\DriverStore\FileRepository\cletus.inf_amd64_neutral_a0df6c14f124e9f8\cletus.inf"'
$ActiGraphWinUsbRegkey = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\296FB17BA308BD1903366BE5B821D9663604DB49'

# Uninstall variables - MS Chart Controls for MS .NET Framework 3.5, delete regkey
$Chart = 'Microsoft Chart Controls for Microsoft .NET Framework 3.5'
$ChartParams = '/X {41785C66-90F2-40CE-8CB5-1C94BFC97280} /qb /norestart'
$ChartRegKey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{41785C66-90F2-40CE-8CB5-1C94BFC97280}'
$MsiExec = ${env:SystemRoot} + '\System32\msiexec.exe'

# Uninstall variables - Delete ActiLife 6 folders
$ActiLife6x64Install = ${env:ProgramFiles} + '\ActiGraph'
$ActiLife6x86Install = ${env:ProgramFiles(x86)} + '\ActiGraph'
$ActiLife6StartMenu = ${env:ProgramData} + '\Microsoft\Windows\Start Menu\Programs\ActiGraph'

Write-Host ""
Write-Host "******************************************************************"
Write-Host ""
Write-Host "$ActiLife6 Uninstall"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "       - $ActiLife6"
Write-Host "       - $ActiGraphUsbDev"
Write-Host "       - $Dynastream"
Write-Host "       - $ActiGraphWinUsb"
Write-Host "       - $Chart"
Write-Host "       - $Chart Uninstall registry key"
Write-Host "       - $ActiLife6 Program Files folder"
Write-Host "       - $ActiLife6 Program Files (x86) folder"
Write-Host "       - $ActiLife6 Start Menu folder"
Write-Host ""
 
# Uninstall ActiLife 6
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $ActiLife6 installation..."
Write-Host ""
 
If ((Test-Path -Path $ActiLife6Regkey) -eq 'True')
{
    Write-Host "    $ActiLife6 is installed."
    Write-Host ""
    Write-Host "Uninstalling $ActiLife6..."
    Write-Host ""
    Write-Host "Command: " $ActiLife6Uninstall
    Write-Host ""
    Start-Process -FilePath $ActiLife6Uninstall -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $ActiLife6 uninstall complete."
    Write-Host ""

}
Else
{
    Write-Host "    $ActiLife6 not installed."
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

# Uninstall Windows Driver Package - Dynastream Innov.
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $Dynastream installation..."
Write-Host ""
 
If ((Test-Path -Path $DynastreamRegkey) -eq 'True')
{
    Write-Host "    $Dynastream is installed."
    Write-Host ""
    Write-Host "Uninstalling $Dynastream driver package..."
    Write-Host ""
    Write-Host "Command: " $DynastreamUninstall $DynastreamParams
    Write-Host ""
    Start-Process -FilePath $DynastreamUninstall -ArgumentList $DynastreamParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "     $Dynastream uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $Dynastream not installed."
    Write-Host ""
}

Start-Sleep 5

# Uninstall Windows Driver Package - ActiGraph (WinUSB)
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $ActiGraphWinUsb installation..."
Write-Host ""
 
If ((Test-Path -Path $ActiGraphWinUsbRegkey) -eq 'True')
{
    Write-Host "    $ActiGraphWinUsb is installed."
    Write-Host ""
    Write-Host "Uninstalling $ActiGraphWinUsb driver package..."
    Write-Host ""
    Write-Host "Command: " $ActiGraphWinUsbUninstall $ActiGraphWinUsbParams
    Write-Host ""
    Start-Process -FilePath $ActiGraphWinUsbUninstall -ArgumentList $ActiGraphWinUsbParams -ErrorVariable +err -Verb Open -Wait 
    Write-Host ""
    Write-Host "    $ActiGraphWinUsb uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $ActiGraphWinUsb not installed."
    Write-Host ""
}

Start-Sleep 5

# Uninstall MS Chart Controls for MS .NET Framework 3.5
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
        Write-Host "Deleting $Chart Uninstall registry key."
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

# Delete ActiLife 6 Program Files folder
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $ActiLife6 Program Files folder..."
Write-Host ""
if ((Test-Path -Path $ActiLife6x64Install) -eq 'True')
{
    Write-Host "    $ActiLife6 install folder exists."
    Write-Host ""
    Write-Host "    Folder location: " 
    Write-Host "    $ActiLife6x64Install"
    Write-Host ""
    Write-Host "Deleting $ActiLife6 install folder..."
    Write-Host ""
    Write-Host "Command:  Remove-Item -Path $ActiLife6x64Install -Recurse -Force"
    Write-Host ""
    Remove-Item -Path $ActiLife6x64Install -Recurse -Force
    Write-Host "" 
    Write-Host "    $ActiLife6 install folder deleted."
    Write-Host ""
}
Else
{
    Write-Host "    $ActiLife6 install folder does not exist."
    Write-Host ""
}
 
Start-Sleep 5

# Delete ActiLife 6 Program Files (x86) folder
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $ActiLife6 Program Files (x86) folder..."
Write-Host ""
if ((Test-Path -Path $ActiLife6x86Install) -eq 'True')
{
    Write-Host "    $ActiLife6 install folder exists."
    Write-Host ""
    Write-Host "    Folder location: " 
    Write-Host "    $ActiLife6x86Install"
    Write-Host ""
    Write-Host "Deleting $ActiLife6 install folder..."
    Write-Host ""
    Write-Host "Command:  Remove-Item -Path $ActiLife6x86Install -Recurse -Force"
    Write-Host ""
    Remove-Item -Path $ActiLife6x86Install -Recurse -Force
    Write-Host "" 
    Write-Host "    $ActiLife6 install folder deleted."
    Write-Host ""
}
Else
{
    Write-Host "    $ActiLife6 install folder does not exist."
    Write-Host ""
}
 
Start-Sleep 5

# Delete ActiLife 6 Start Menu folder
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $ActiLife6 Start Menu folder..."
Write-Host ""
\if ((Test-Path -Path $ActiLife6StartMenu) -eq 'True')
{
    Write-Host "    $ActiLife6 Start Menu folder exists."
    Write-Host ""
    Write-Host "    Folder location: " 
    Write-Host "    $ActiLife6StartMenu"
    Write-Host ""
    Write-Host "Deleting $ActiLife6 Start Menu folder..."
    Write-Host ""
    Write-Host "Command:  Remove-Item -Path $ActiLife6StartMenu -Recurse -Force"
    Write-Host ""
    Remove-Item -Path $ActiLife6StartMenu -Recurse -Force
    Write-Host "" 
    Write-Host "    $ActiLife6 Start Menu folder deleted."
    Write-Host ""
}
Else
{
    Write-Host "    $ActiLife6 Start Menu folder does not exist"
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5