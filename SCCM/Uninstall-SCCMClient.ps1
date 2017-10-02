#Requires -RunASAdministrator

# Uninstaller for SCCM client with extras

$filepath="C:\Windows\ccmsetup\ccmsetup.exe"

if (Test-Path $filepath){

c:\Windows\ccmsetup\ccmsetup.exe /uninstall

# Remove directories left behind by uninstaller
write-host "Removing directories left behind by the unistaller ...`r"
remove-item /s c:\windows\ccm
remove-item /s c:\windows\ccmcache
remove-item /s c:\windows\ccmsetup
remove-item c:\windows\smscfg.ini
remove-item c:\windows\SMSAdvancedClient.*

# Remove registry keys left behind by the uninstaller
# There may be muliple instances of the same key
write-host "Removing registry keys left behind by the unistaller ...`r"
reg delete HKLM\software\Microsoft\CCM /va /f
reg delete HKLM\software\Microsoft\CCMSetup /va /f
reg delete HKLM\software\Microsoft\SMS /va /f
reg delete HKLM\software\Microsoft\SystemCertificates\SMS\Certificates /va /f
}

else{
write-host "The ccmsetup.exe is not installed on this computer"
pause
exit
}

write-host "SCCM Client unistall is complete!!!!!!! <3 `r"
pause
