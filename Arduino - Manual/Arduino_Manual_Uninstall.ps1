<#
    .SYNOPSIS
      SCCM Uninstall program for Arduino 1.0.6 (32-bit) 

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Stop the Java process if running
        - Arduino 1.0.6
        - WIN7 RUNASADMIN compatibility mode setting

    .NOTES
      FileName: Arduino_Manual_Uninstall.ps1
      Author: Jerry Senff
      Updated: 12/11/2016
      Comments: Powershell.exe –executionpolicy bypass –file "Arduino_Manual_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Arduino_Manual_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath
 
# Stop the Java process if running
$JavaDescription = 'Java(TM) Platform SE binary'
$JavaProcess = 'javaw *32'
 
# Uninstall Arduino 1.0.6
$Arduino = 'Arduino'
$ArduinoRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Arduino'
$Cmd = ${env:SystemRoot} + '\System32\cmd.exe'
 
# Remove WIN7 RUNASADMIN compatibility mode
$CompModePath = 'HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers'
$CompSetting = '*arduino.exe'
$CompMode = 'WIN7 RUNASADMIN'
 
Write-Host ""
Write-Host "******************************************************************"
Write-Host ""
Write-Host "$Arduino Uninstaller"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "       - Stop $JavaDescription process"
Write-Host "       - Uninstall $Arduino"
Write-Host "       - Remove $CompMode compatibility mode"
Write-Host ""
 
# Uninstall Arduino 1.0.6
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $Arduino installation..."
Write-Host ""
 
If ((Test-Path -Path $ArduinoRegkey) -eq 'True')
{
    Write-Host "    $Arduino is installed."
    Write-Host ""
    Write-Host "Checking for running $JavaDescription process..."
    Write-Host ""
    
    # Stop the Java process if running
    If ((Get-Process $JavaProcess) -eq 'True')
    {
        Write-Host "    $JavaDescription process is running."
        Write-Host ""
        Write-Host "Stopping $JavaDescription process..."
        Write-Host ""    
        Write-Host "Command:  Stop-Process -ProcessName $JavaProcess -Force -Verbose"
        Stop-Process -ProcessName $JavaProcess -Force -Verbose
        Write-Host ""
        Write-Host "    $JavaDescription process stopped."
        Write-Host ""
        Start-Sleep 5
    }
    Else
    {
        Write-Host "    $JavaDescription process is not running."
        Write-Host ""
    }

    $CmdParams = '/c ' + (Get-ItemProperty $ArduinoRegkey).UninstallString    
 
    Write-Host "Uninstalling $Arduino..."
    Write-Host ""
    Write-Host "Command:  $Cmd $CmdParams"
    Start-Process -FilePath $Cmd -ArgumentList $CmdParams -ErrorVariable +err -Verb Open -Wait 
    Write-Host ""
    Write-Host "    $Arduino uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $Arduino is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
# Remove WIN7 RUNASADMIN compatibility mode
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $Arduino $CompMode compatibility mode setting..."
Write-Host ""
 
if (Get-ItemProperty $CompModePath -name $CompSetting)
{
    Write-Host "    $Arduino $CompMode compatibility mode setting present..."
    Write-Host ""
    Write-Host "Removing $Arduino $CompMode compatibility mode setting..."
    Write-Host ""
    Write-Host "Command: Remove-ItemProperty -Path $CompModePath -name $CompSetting -Force"
    Remove-ItemProperty -Path $CompModePath -name $CompSetting -Force
    Write-Host ""
    Write-Host "    $Arduino $CompMode compatibility mode setting removal complete."
    Write-Host ""
}
else
{
    Write-Host "    $Arduino $CompMode compatibility mode setting does not exist."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
