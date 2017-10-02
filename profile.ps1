# PowerShell profile for captam3rica

###################
##    Modules    ##
###################

import-module C:\Users\jwils156\Documents\WindowsPowerShell\Get-ChildItemColor-develop\Get-ChildItemColor-develop\Get-ChildItemColor.psm1

###################
##  Alias Info   ##
###################

Set-Alias l Get-ChildItemColor -option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -option AllScope

("")
write-host "Be strong and of great courage. `r
Do not be afraid or dismayed, for the Lord `r
your God is with you wherever you go. `r
 -Joshua 1:9" -foregroundcolor cyan
("")
write-host "The shell is only the beginning ... `n" -foregroundcolor green

###################
## COMPUTER INFO ##
###################

$OSInfo = get-wmiobject win32_operatingsystem
$IPAddress = (Get-NetIPAddress -AddressState Preferred -AddressFamily IPv4 | where-object {$_.IPAddress -ne '127.0.0.1'}).IPAddress
$BootTime = $OSInfo.converttodatetime($OSInfo.lastbootuptime)
$CalcUptime = $OSInfo.converttodatetime($OSInfo.localdatetime) - $BootTime
$Uptime = "$CalcUptime"
$Day = $Uptime.split(".")
$Hours = $Uptime.split(".").split(":")
$Minutes = $Uptime.split(":").split(":")

write-host "Computer Name:" $env:COMPUTERNAME
write-host "IP Address:" $IPAddress
write-host "BootTime:" $BootTime
write-host "Uptime:" $Day[0] "Days" $Hours[1] "Hours" $Minutes[1] "Minutes"
("")
