<#
    .SYNOPSIS
      SCCM Uninstall program for Agilent IntuiLink Waveform

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Uninstall Agilent IntuiLink Waveform

    .NOTES
      FileName: Agilent_Intuilink_Waveform_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/28/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Agilent_Intuilink_Waveform_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Agilent_Intuilink_Waveform_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Agilent IntuiLink Waveform
$IntuiLink = 'Agilent IntuiLink Waveform'
$IntuiLinkUninstall = 'RunDll32'
$IntuiLinkParams = (${env:SystemDrive} + '\PROGRA~2\COMMON~1\INSTAL~1\engine\6\INTEL3~1\Ctor.dll,LaunchSetup "' + ${env:ProgramFiles(x86)} + '\InstallShield Installation Information\{69B5E6F5-F46D-4B96-9B1B-5DD3D6240DE3}\Setup.exe"')
$IntuiLinkRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{69B5E6F5-F46D-4B96-9B1B-5DD3D6240DE3}'
 
Write-Host ""
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "$IntuiLink Uninstaller"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - Uninstall $IntuiLink"
Write-Host ""
 
# Uninstall Agilent IntuiLink Waveform
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $IntuiLink installation..."
Write-Host ""
 
If ((Test-Path -Path $IntuiLinkRegkey) -eq 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $IntuiLink is installed."
    Write-Host ""
    Write-Host "Uninstalling $IntuiLink..."
    Write-Host ""
    Write-Host "Command:  $IntuiLinkUninstall $IntuiLinkParams"
    Write-Host ""
    Start-Process -FilePath $IntuiLinkUninstall -ArgumentList $IntuiLinkParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $IntuiLink uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $IntuiLink is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
