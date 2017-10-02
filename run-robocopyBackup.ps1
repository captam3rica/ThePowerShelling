#Requires -RunAsAdministrator

robocopy.exe $env:USERPROFILE .\RoboTest\ /MIR /XF NTUSER.DAT* /XD RoboTest\
