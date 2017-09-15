# Calculates the computer uptime

# http://windowsitpro.com/powershell/powershell-basics-filtering-objects

$OSInfo = get-wmiobject win32_operatingsystem
$BootTime = $OSInfo.converttodatetime($OSInfo.lastbootuptime)
$CalcUptime = $OSInfo.converttodatetime($OSInfo.localdatetime) - $BootTime
$Uptime = $CalcUptime.ToString()

$Day = $Uptime.split(".")
$Hours = $Uptime.split(".").split(":")
$Minutes = $Uptime.split(":").split(":")

write-host "BootTime:" $BootTime
write-host "Uptime:" $Day[0] "Days" $Hours[1] "Hours" $Minutes[1] "Minutes"
