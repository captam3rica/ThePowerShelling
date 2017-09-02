#Requires -RunAsAdministrator

# Removes a device from SCCM console

[cmdletbinding(SupportsShouldProcess=$True)]

# Load InputBox
[void][system.reflection.assembly]::loadwithpartialname('Microsoft.VisualBasic')

$site = [Microsoft.VisualBasic.interaction]::inputbox('Enter CM Site Code','Site?')
# Run GUI input
$computerName = [Microsoft.Visualbasic.interaction]::inputbox('Enter a computer name','Computer?')

# Check to see if device exists in Console
cls
write-host "Changing location to Site Server ..." -foregroundcolor yellow
set-location $site | out-null

write-host "Looking for $computerName in the SCCM console ..." -foregroundcolor yellow
$checkSCCM = [Boolean](get-cmdevice -name $computerName)

If ($checkSCCM -eq $True) {
  (Remove-CMDevice -DeviceName $computerName)
  write-output "$computerName was removed from SCCM"
}
else {
  write-host "$computerName not in SCCM"
}

# Change location back to local machine

set-location C: | out-null
