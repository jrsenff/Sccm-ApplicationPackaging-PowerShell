<#
    .SYNOPSIS
      SCCM Uninstall program for Accelyrs DS Gene 1.5 (32-bit) 

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Accelyrs DS Gene 1.5
        - Accelrys License Pack 6.2

    .NOTES
      FileName: AccelyrsDSGene15_Manual_Uninstall.ps1
      Author: Jerry Senff
      Updated: 12/06/2016
      Comments: Powershell.exe –executionpolicy bypass –file "AccelyrsDSGene15_Manual_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\AccelyrsDSGene_Manual_Uninstall.txt'
$errFileLocation =  (${env:SystemDrive} + $errorpath)

$MsiExec = (${env:SystemRoot} + '\System32\msiexec.exe')

# Uninstall Accelyrs DS Gene 1.5
$DSGene = 'Accelyrs DS Gene 1.5'
$DSGeneParams = '/x {2B6F3DC6-1312-456C-BEB5-4D7BA4102A08} /qn /norestart'
$DSGeneRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{2B6F3DC6-1312-456C-BEB5-4D7BA4102A08}'
 
# Uninstall Accelrys License Pack 6.2
$LicensePack = 'Accelrys License Pack 6.2'
$LicensePackParams = '/x {8F548932-DF68-4768-8A0F-34A641A38406} /qn /norestart'
$LicensePackRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{8F548932-DF68-4768-8A0F-34A641A38406}'
 
Write-Host ""
Write-Host "******************************************************************"
Write-Host ""
Write-Host "$DSGene Uninstall"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - Uninstall $DSGene"
Write-Host "         - Uninstall $LicensePack"
Write-Host ""
 
# Uninstall Accelyrs DS Gene 1.5
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $DSGene installation...*"
Write-Host ""
 
If ((Test-Path -Path $DSGeneRegkey) -eq 'True')
{
    Write-Host "    $DSGene is installed."
    Write-Host ""
    Write-Host "Uninstalling $DSGene..."
    Write-Host ""
    Write-Host "Command: " $MsiExec $DSGeneParams
    Write-Host ""
    Start-Process -FilePath $MsiExec -ArgumentList $DSGeneParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $DSGene uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $DSGene not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
#  Uninstall Accelrys License Pack 6.2
set-location $startLocation
Write-Host "******************************************************************"
Write-Host ""
Write-Host "Checking for $LicensePack installation...*"
Write-Host ""
 
If ((Test-Path -Path $LicensePackRegkey) -eq 'True')
{
    Write-Host "    $LicensePack is installed."
    Write-Host ""
    Write-Host "Uninstalling $LicensePack..."
    Write-Host ""
    Write-Host "Command: " $MsiExec $LicensePackParams
    Write-Host ""
    Start-Process -FilePath $MsiExec -ArgumentList $LicensePackParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $LicensePack uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $LicensePack not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
# Indicate location of log file.
$err | Out-File $errFileLocation
Write-Host "*** Log file location = $errFileLocation ***"
 
Start-Sleep 5
