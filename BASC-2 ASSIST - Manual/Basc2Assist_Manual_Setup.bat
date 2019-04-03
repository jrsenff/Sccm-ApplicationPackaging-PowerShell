@echo off
rem BASC-2 ASSIST installation batch file
rem 
rem Sets Windows XP SP3 Compatibility Mode on Setup.exe
rem
rem Author: Jerry Senff
rem Created: 140314
rem Updated: 190403
rem
 
rem Set Compatibility Layer to Windows XP
set __COMPAT_LAYER=WINXPSP3
 
rem Run the setup program
 
"Setup.exe"
 
rem timeout /t 20
 
rem End of batch file