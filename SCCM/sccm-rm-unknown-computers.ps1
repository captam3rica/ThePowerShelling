#Requires -RunAsAdministrator

# Removes unknown computers from the SCCM console

$site = <SITE CODE?
$computerName = "Unknown*"

# Switching to SCCM site
write-host "Changing location to $site ..." -foregroundcolor yellow
set-location $site | out-null

("")

write-host "Looking for $computerName computers in the SCCM console ..." -foregroundcolor yellow
$checkSCCM = [Boolean](get-cmdevice -name $computerName)

("")

if ($checkSCCM -eq $True)
{
  (Remove-CMDevice -DeviceName $computerName -Force)
  write-host "$computerName removed!" -foregroundcolor green
}
else
{
  write-host "$computerName not in SCCM ..." -foregroundcolor red
}

# Change location back to local machine
set-location C: | out-null

write-host "All computers have been removed!" -foregroundcolor green
