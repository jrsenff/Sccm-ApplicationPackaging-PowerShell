<#
    .SYNOPSIS
      SCCM Uninstall program for Adobe InDesign CS6

    .DESCRIPTION
      Remove the following component(s) from Window 7 x64 systems:
        - Adobe InDesign CS6

    .NOTES
      FileName: Adobe_InDesignCS6_Uninstall.ps1
      Author: Jerry Senff
      Updated: 02/26/2019
      Comments: Powershell.exe –executionpolicy bypass –file "Adobe_InDesignCS6_Uninstall.ps1"
#>
 
# Error file
$startLocation = Get-Location
$err=@()
$errorpath = '\ErrorLogs\Adobe_InDesignCS6_Uninstall.txt'
$errFileLocation =  ${env:SystemDrive} + $errorpath

# Update variables - Adobe Application Manager Enterprise 3.1
$AppMgrUpdate = './AdobeAppMgrEnterprise3-1/Setup.exe'
$AppMgrParams = '--mode=silent --action=update'
 
# Uninstall variables - Adobe InDesign CS6
$InDesignPdapp = '/Common Files/Adobe/OOBE/PDApp/core/PDApp.exe'
$InDesignUninstall = (${env:ProgramFiles(x86)} + $InDesignPdapp)
$InDesignParams = '--appletID="DWA_UI" --appletVersion="2.0" --mode="Uninstall" --mediaSignature="{CFB770D7-8D43-1014-922B-CC2715FADE3F}"'
$InDesignRegkey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{CFB770D7-8D43-1014-922B-CC2715FADE3F}'
 
Write-Host ""
Write-Host "******** Adobe InDesign CS6 Uninstaller *************************************"
Write-Host ""
Write-Host "Purpose: Removes Adobe InDesign CS6"
Write-Host "         - Update the Adobe Application Manager"
Write-Host "         - Uninstall InDesign CS6"
Write-Host ""
 
# Update Adobe Adobe Application Manager Enterprise 3.1
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Starting Adobe App Mgr Enterprise 3.1 update...*"
Write-Host ""
Write-Host "Command: " $AppMgrUpdate $AppMgrParams
Write-Host ""
Start-Process -FilePath $AppMgrUpdate -ArgumentList $AppMgrParams -ErrorVariable +err -Verb Open -Wait 
Write-Host ""
Write-Host "Adobe App Mgr Enterprise 3.1 update complete."
Write-Host ""
 
sleep 5
 
# Uninstall Adobe InDesign CS6
set-location $startLocation
Write-Host "****************************************************************************"                  
Write-Host ""
Write-Host "Checking for Adobe InDesign CS6 installation...*"
Write-Host ""
 
If ((Test-Path -Path $InDesignRegkey) -eq 'True')
{
    Write-Host "    Adobe InDesign CS6 is installed."
    Write-Host ""
    Write-Host "Uninstalling Adobe InDesign CS6..."
    Write-Host ""
    Write-Host "Command: " $InDesignUninstall $InDesignParams
    Write-Host ""
    Start-Process -FilePath $InDesignUninstall -ArgumentList $InDesignParams -ErrorVariable +err -Verb Open -Wait
    Write-Host ""
    Write-Host "    Adobe InDesign CS6 uninstall complete."
    Write-Host ""
}
Else
{
    Write-Host "    Adobe InDesign CS6 not installed."
    Write-Host ""
}
 
Start-Sleep 5
 
$err | Out-File $errFileLocation
Write-Host "*** Log file location = " $errFileLocation " ***"
 
Start-Sleep 5
