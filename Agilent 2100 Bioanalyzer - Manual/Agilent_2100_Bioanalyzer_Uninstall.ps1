<#
    .SYNOPSIS
      SCCM Uninstall program for Agilent 2100 Bioanalyzer

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Uninstall Agilent 2100 Bioanalyzer
        - Uninstall CodeSite 4.4 Tools
        - Remove leftover install folders

    .NOTES
      FileName: Agilent_2100_Bioanalyzer_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/28/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Agilent_2100_Bioanalyzer_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Agilent_2100_Bioanalyzer_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - Agilent 2100 Bioanalyzer
$BioanalyzerUninstall = ('"' + ${env:ProgramFiles(x86)} + '\InstallShield Installation Information\{F60B80F1-7F44-4491-AD8D-7100A3F66A44}\setup.exe"')
$BioanalyzerParams = '-runfromtemp -l0x0409'
$BioanalyzerRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\InstallShield_{F60B80F1-7F44-4491-AD8D-7100A3F66A44}'
$BioanalyzerInstallFolder = (${env:ProgramFiles(x86)} + '\Agilent')
 
# Uninstall variables - CodeSite 4.4 Tools
$CodeSiteUninstall = ('"' + ${env:ProgramFiles(x86)} + '\Raize\CS4\UNWISE.EXE"')
$CodeSiteParams = ('"' + ${env:ProgramFiles(x86)} + '\Raize\CS4\CS4_Tools_Install.log"')
$CodeSiteRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\CodeSite 4.4 Tools'
$CodeSiteInstallFolder = (${env:ProgramFiles(x86)} + '\Raize')
$CodeSiteDispatcher = "CSDispatcher"
 
Write-Host ""
Write-Host "******** Bioanalyzer Uninstaller ********************************************"
Write-Host ""
Write-Host "Purpose: Removes Bioanalyzer and components:"
Write-Host "         - Uninstalls Agilent 2100 Bioanalyzer"
Write-Host "         - Uninstalls CodeSite 4.4 Tools"
Write-Host ""
 
# Uninstall Agilent 2100 Bioanalyzer
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Bioanalyzer installation...*"
Write-Host ""
 
If ((Test-Path -Path $BioanalyzerRegkey) -eq 'True')
{
    Write-Host "    Bioanalyzer is installed."
    Write-Host ""
    Write-Host "Uninstalling Bioanalyzer..."
    Write-Host ""
    Write-Host "Command: " $BioanalyzerUninstall $BioanalyzerParams
    Write-Host ""
    Start-Process -FilePath $BioanalyzerUninstall -ArgumentList $BioanalyzerParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "Bioanalyzer uninstall complete."
    Write-Host ""
Else
{
    Write-Host "    Bioanalyzer not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
# Uninstall CodeSite 4.4 Tools
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for CodeSite installation...*"
Write-Host ""
 
If ((Test-Path -Path $CodeSiteRegkey) -eq 'True')
{
    Write-Host "    CodeSite is installed."
    Write-Host ""
    Write-Host "Stopping CodeSite Dispatcher..."
    Write-Host ""
    Write-Host "Command:  Stop-Process -Force -Name $CodeSiteDispatcher -Verbose"
    Write-Host ""
    Stop-Process -Force -Name $CodeSiteDispatcher -Verbose
    Write-Host ""
    Write-Host "Uninstalling CodeSite..."
    Write-Host ""
    Write-Host "Command: " $CodeSiteUninstall $CodeSiteParams
    Write-Host ""
    Start-Process -FilePath $CodeSiteUninstall -ArgumentList $CodeSiteParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "CodeSite uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    CodeSite not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
# Check for Bioanalyzer install folder
Write-Host "    *********** Bioanalyzer install folder check ***************************"
Write-Host "    Folder location: " $BioanalyzerInstallFolder
Write-Host ""
if ((Test-Path -Path $BioanalyzerInstallFolder) -eq 'True')
{
    Write-Host "    Bioanalyzer install folder exists."
    Write-Host ""
    Write-Host ""
    Write-Host "Deleting Bioanalyzer install folder..."
    Write-Host ""
    Write-Host "Command:  Remove-Item -Path $BioanalyzerInstallFolder -Recurse -Force"
    Write-Host ""
    Remove-Item -Path $BioanalyzerInstallFolder -Recurse -Force
    Write-Host "" 
    Write-Host "Bioanalyzer install folder deleted."
    Write-Host ""
}
Else
{
    Write-Host "    Bioanalyzer install folder does not exist"
    Write-Host ""
}
 
Start-Sleep 5
 
# Check for CodeSite install folder
Write-Host "    *********** CodeSite install folder check ***************************"
Write-Host "    Folder location: " $CodeSiteInstallFolder
Write-Host ""
if ((Test-Path -Path $CodeSiteInstallFolder) -eq 'True')
{
    Write-Host "    CodeSite install folder exists."
    Write-Host ""
    Write-Host ""
    Write-Host "Deleting CodeSite install folder..."
    Write-Host ""
    Write-Host "Command:  Remove-Item -Path $CodeSiteInstallFolder -Recurse -Force"
    Write-Host ""
    Remove-Item -Path $CodeSiteInstallFolder -Recurse -Force
    Write-Host "" 
    Write-Host "CodeSite install folder deleted."
    Write-Host ""
}
Else
{
    Write-Host "    CodeSite install folder does not exist"
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
