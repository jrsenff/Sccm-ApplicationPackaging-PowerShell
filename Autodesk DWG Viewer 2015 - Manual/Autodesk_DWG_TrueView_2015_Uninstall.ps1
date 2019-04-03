<#
    .SYNOPSIS
      SCCM Uninstall program for Autodesk DWG TrueView 2015

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Autodesk DWG TrueView 2015

    .NOTES
      FileName: Autodesk_DWG_TrueView_2015_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/28/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Autodesk_DWG_TrueView_2015_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Autodesk_DWG_TrueView_2015_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Autodesk DWG TrueView 2015
$Autodesk = 'Autodesk DWG TrueView 2015'
$AutodeskUninstall = ('"' + ${env:ProgramFiles} + '\Autodesk\DWG TrueView 2015 - English\Setup\Setup.exe"')
$AudodeskParams = '/P {5783F2D7-E028-0409-0100-0060B0CE6BBA} /M AOEM /language en-US'
$AutodeskRegkey = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DWG TrueView 2015 - English'
 
Write-Host ""
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "$Autodesk Uninstaller"
Write-Host ""
Write-Host "Purpose: Removes the following components:"
Write-Host "         - Uninstall $Autodesk"
Write-Host ""
 
#  Uninstall Autodesk DWG TrueView 2015
Set-Location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $Autodesk installation..."
Write-Host ""
 
If ((Test-Path -Path $AutodeskRegkey) -eq 'True')
{
    Write-Host "    $Autodesk is installed."
    Write-Host ""
    Write-Host "Uninstalling $Autodesk..."
    Write-Host ""
    Write-Host "Command: " $AutodeskUninstall $AudodeskParams
    Write-Host ""
    Start-Process -FilePath $AutodeskUninstall -ArgumentList $AudodeskParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "$Autodesk uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $Autodesk not installed."
    Write-Host ""
}

Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
