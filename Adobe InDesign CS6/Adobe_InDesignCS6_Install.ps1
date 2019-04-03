<#
    .SYNOPSIS
      SCCM Install program for Adobe InDesign CS6

    .DESCRIPTION
      Install the following component(s) on Window 7 x64 systems:
        - Adobe InDesign CS6

    .NOTES
      FileName: Adobe_InDesignCS6_Install.ps1
      Author: Jerry Senff
      Updated: 02/26/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Adobe_InDesignCS6_Install.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Adobe_InDesignCS6_Install.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Install variables - Adobe InDesign CS6
$AppName1 = 'Adobe InDesign CS6'
$InDesignInstall = (${env:SystemRoot} + '\System32\msiexec.exe')
$InDesignParams = '/i "AdobeInDesignCS6.msi" /qn /norestart'
$InDesignRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{CFB770D7-8D43-1014-922B-CC2715FADE3F}'
 
Write-Host ""
Write-Host "**** Adobe InDesign CS6 Installer ****"
Write-Host ""
 
#  Install Adobe InDesign CS6  #
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for $AppName1 installation...*"
Write-Host ""
 
If ((Test-Path -Path $InDesignRegkey) -ne 'True')
{
    Write-Host "    $AppName1 is not installed."
    Write-Host ""
    Write-Host "Installing $AppName1..."
    Write-Host ""
    Write-Host "Command: " $InDesignInstall $InDesignParams
    Write-Host ""
    Start-Process -FilePath $InDesignInstall -ArgumentList $InDesignParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    $AppName1 install complete."
    Write-Host ""
}
Else
{
    Write-Host "    $AppName1 already installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
