<#
    .SYNOPSIS
      SCCM Uninstall program for Analyse-It for MS Excel

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Analyse-It for MS Excel

    .NOTES
      FileName: Analyse_It_for_MS_Excel_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/28/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Analyse_It_for_MS_Excel_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Analyse_It_for_MS_Excel_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Analyse-It for MS Excel
$AnalyseIt = 'Analyse-it for MS Excel' 
$AnalyseItUninstall = ('"' + ${env:ProgramFiles(x86)} + '\Analyse-it\system\setup.exe"')
$AnalyseItParams = '/u'
$AnalyseItRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Analyse-it for Excel'
 
Write-Host ""
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "$AnalyseIt Uninstaller"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - Uninstall $AnalyseIt"
Write-Host ""
 
# Uninstall Analyse-It for MS Excel
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $AnalyseIt installation..."
Write-Host ""
 
If ((Test-Path -Path $AnalyseItRegkey) -eq 'True')  # Check uninstall registry key or install path
{
    Write-Host "    $AnalyseIt is installed."
    Write-Host ""
    Write-Host "Uninstalling $AnalyseIt..."
    Write-Host ""
    Write-Host "Command:  $AnalyseItUninstall $AnalyseItParams"
    Write-Host ""
    Start-Process -FilePath $AnalyseItUninstall -ArgumentList $AnalyseItParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $AnalyseIt uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $AnalyseIt is not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
