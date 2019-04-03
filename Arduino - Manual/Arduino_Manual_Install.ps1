<#
    .SYNOPSIS
      SCCM Install program for Arduino 1.0.6 (32-bit) 

    .DESCRIPTION
      Install the following component(s) on Window 7 x64 systems:
        - Arduino 1.0.6
        - Set WIN7 RUNASADMIN compatibility mode

    .NOTES
      FileName: Arduino_Manual_Install.ps1
      Author: Jerry Senff
      Updated: 12/11/2016
      Comments: Powershell.exe –executionpolicy bypass –file "Arduino_Manual_Install.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Arduino_Manual_Install.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath
 
# Install Arduino 1.0.6
$Arduino = 'Arduino 1.0.6'
$ArduinoInstall = 'arduino-1.0.6-windows.exe'
$ArduinoRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Arduino'
 
#  Set WIN7 RUNASADMIN compatibility mode
$ArduinoExePath = ${env:ProgramFiles(x86)} + '\Arduino\arduino.exe'
$CompModePath = 'HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers'
$CompMode = 'WIN7 RUNASADMIN'

Write-Host ""
Write-Host "******************************************************************"
Write-Host ""
Write-Host "$Arduino Install"
Write-Host ""
Write-Host "Purpose: Install the following components:"
Write-Host "       - $Arduino"
Write-Host "       - Set $CompMode compatibility mode"
Write-Host ""
 
# Install Arduino 1.0.6
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $Arduino installation..."
Write-Host ""
 
If ((Test-Path -Path $ArduinoRegkey) -ne 'True')
{
    Write-Host "    $Arduino is not installed."
    Write-Host ""
    Write-Host "Installing $Arduino..."
    Write-Host ""
    Write-Host "Command:  $ArduinoInstall"
    Write-Host ""
    Start-Process -FilePath $ArduinoInstall -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $Arduino install complete."
    Write-Host ""
}
Else
{
    Write-Host "    $Arduino is already installed."
    Write-Host ""
}
 
Start-Sleep 5
 
#  Set WIN7 RUNASADMIN compatibility mode
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Setting $Arduino compatibility mode to $CompMode..."
Write-Host ""
Write-Host "Command:  New-ItemProperty -Path $CompModePath -Name $ArduinoExePath -Value $CompMode"
Write-Host ""
New-ItemProperty -Path $CompModePath -Name $ArduinoExePath -Value $CompMode
Write-Host ""
Write-Host "    $Arduino compatibility mode setting complete."
Write-Host ""
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = $errFileLocation ***"
Write-Host ""
 
Start-Sleep 5
