# Calculates the computer uptime

# http://windowsitpro.com/powershell/powershell-basics-filtering-objects

$LBUT = (get-ciminstance win32_operatingsystem).lastbootuptime
$dateTime= [datetime]::now

$CalcUptime = $dateTime - $LBUT #| select days, hours, minutes, seconds
$Uptime = $CalcUptime.ToString()

$Day = $Uptime.split(".")
$Hours = $Uptime.split(".").split(":")
$Minutes = $Uptime.split(":").split(":")
$Seconds = $Uptime.split(":").split(".")

write-host "BootTime:" $LBUT
# write-host "Uptime:" $Day[0] "Days" $Hours[1] "Hours" $Minutes[1] "Minutes"

write-host $dateTime $Day[0] "days, "$Hours[1]":"$Minutes[2]":"$Seconds[3]
