<#
    .SYNOPSIS
      SCCM Uninstall program for BASC2-ASSIST

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - ScanTools Plus Link Runtime
        - BASC2-ASSIST
        - Java(TM) 6 Update 2

    .NOTES
      FileName: Basc2Assist_Manual_Uninstall.ps1
      Author: Jerry Senff
      Updated: 04/02/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Basc2Assist_Manual_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Basc2Assist_Manual_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Uninstall variables - ScanTools Plus Link Runtime
$ScanToolsName = 'ScanTools Plus Link Runtime'
$ScanToolsUninstall = ('"' + ${env:ProgramFiles(x86)} + '\InstallShield Installation Information\{265F31FE-5731-424E-8B55-E2E1F17E5F3E}\setup.exe"')
$ScanToolsParams = '-runfromtemp -l0x0009AnyText -removeonly'
$ScanToolsInstallFolder = (${env:ProgramFiles(x86)} + '\Common Files\Pearson NCS Shared\ScanTools Plus Link\Runtime')
$ScanToolsRegKey = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{265F31FE-5731-424E-8B55-E2E1F17E5F3E}'
 
# Uninstall variables - BASC2-ASSIST
$Basc2Name = 'BASC2-ASSIST'
$Basc2String = '\Pearson\BASC-2 ASSIST\Uninstall_Intervention Report Upgrade for BASC-2 ASSIST\Uninstall Intervention Report Upgrade for BASC-2 ASSIST.exe'
$Basc2Uninstaller = (${env:ProgramFiles(x86)} + $Basc2String)
$Basc2Regkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Intervention Report Upgrade for BASC-2 ASSIST'
 
# Uninstall variables - Java(TM) 6 Update 2
$MsiExec = (${env:SystemRoot} + '\System32\msiexec.exe')
$JavaName = 'Java(TM) 6 Update 2'
$JavaParams = '/x {3248F0A8-6813-11D6-A77B-00B0D0160020} /qn /norestart'
$JavaRegKey = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{3248F0A8-6813-11D6-A77B-00B0D0160020}'

Write-Host ""
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "$BascName Uninstaller"
Write-Host ""
Write-Host "Purpose: Remove the following components:"
Write-Host "         - Uninstall $ScanToolsName"
Write-Host "         - Uninstall $Basc2Name"
Write-Host "         - Uninstall $JavaName"
Write-Host ""
 
# Uninstall ScanTools Plus Link Runtime
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $ScanToolsName installation..."
Write-Host ""
 
if ((Test-Path -Path  $ScanToolsRegKey) -eq 'True')
{
    Write-Host "    $ScanToolsName is installed."
    Write-Host ""
    Write-Host "Uninstalling $ScanToolsName..."
    Write-Host ""
    Write-Host "Command: " $ScanToolsUninstall $ScanToolsParams
    Write-Host ""
    Start-Process -FilePath $ScanToolsUninstall -ArgumentList $ScanToolsParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "$ScanToolsName uninstall complete."
    Write-Host ""
 
    if ((Test-Path -Path $ScanToolRegKey) -eq 'True')
    {
        Write-Host "Removing $ScanToolsName uninstall registry key..."
        Write-Host ""
        Write-Host "Command:  Remove-Item -Path $ScanToolRegKey -Recurse -Force"
        Write-Host ""
        Remove-Item -Path $ScanToolRegKey -Recurse -Force
        Write-Host ""
        Write-Host "$ScanToolsName uninstall registry key removal complete."
        Write-Host ""
    }
    else
    {
        Write-Host "    $ScanToolsName uninstall registry key does not exist"
        Write-Host ""
    }
 
    if ((Test-Path -Path $ScanToolsInstallFolder) -eq 'True')
    {
        Write-Host "Deleting $ScanToolsName install folder..."
        Write-Host ""
        Write-Host "Command:  Remove-Item -Path $ScanToolsInstallFolder -Recurse -Force"
        Write-Host ""
        Remove-Item -Path $ScanToolsInstallFolder -Recurse -Force
        Write-Host ""
        Write-Host "$ScanToolsName install folder removal complete."
        Write-Host ""
    }
    else
    {
        Write-Host "    $ScanToolsName install folder does not exist"
        Write-Host ""
    }
}
Else
{
    Write-Host "    $ScanToolsName not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
# Uninstall BASC2-ASSIST
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $Basc2Name installation..."
Write-Host ""
 
If ((Test-Path -Path $Basc2Regkey) -eq 'True')
{
    Write-Host "    $Basc2Name is installed."
    Write-Host ""
    Write-Host "Uninstalling $Basc2Name..."
    Write-Host ""
    Write-Host "Command: " $Basc2Uninstaller
    Write-Host ""
    Start-Process -FilePath $Basc2Uninstaller -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "$Basc2Name uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $Basc2Name not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
# Uninstall Java(TM) 6 Update 2
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $JavaName installation..."
Write-Host ""
 
If ((Test-Path -Path $JavaRegKey) -eq 'True')
{
    Write-Host "    $JavaName is installed."
    Write-Host ""
    Write-Host "Uninstalling $JavaName..."
    Write-Host ""
    Write-Host "Command: " $MsiExec $JavaParams
    Write-Host ""
    Start-Process -FilePath $MsiExec -ArgumentList $JavaParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "$JavaName uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    $JavaName not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
