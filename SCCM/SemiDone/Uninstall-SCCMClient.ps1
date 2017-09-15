#Requires -RunASAdministrator

# Uninstaller for SCCM client with extras

$filepath="C:\Windows\ccmsetup\ccmsetup.exe"

if (Test-Path $filepath){

c:\Windows\ccmsetup\ccmsetup.exe /uninstall

# Remove directories left behind by uninstaller
RD /s /q c:\windows\ccm
RD /s /q c:\windows\ccmcache
RD /s /q c:\windows\ccmsetup
DEL c:\windows\smscfg.ini
DEL c:\windows\SMSAdvancedClient.*

# Remove registry keys left behind by the uninstaller
# There may be muliple instances of the same key
reg delete HKLM\software\Microsoft\CCM /va /f
reg delete HKLM\software\Microsoft\CCMSetup /va /f
reg delete HKLM\software\Microsoft\SMS /va /f
reg delete HKLM\software\Microsoft\SystemCertificates\SMS\Certificates /va /f
}

else{
write-host "The ccmsetup.exe file is not on this computer"
}
