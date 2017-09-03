#Requires -RunAsAdministrator

# Removes a device from SCCM console

[cmdletbinding(SupportsShouldProcess=$True)]

# Load InputBox
[void][system.reflection.assembly]::loadwithpartialname('Microsoft.VisualBasic')

# Run GUI input
$site = [Microsoft.VisualBasic.interaction]::inputbox('Enter CM Site Code','Site?')
$computerName = [Microsoft.Visualbasic.interaction]::inputbox('Enter a computer name','Computer?')

# Check to see if device exists in Console
cls
write-host "Changing location to Site Server ..." -foregroundcolor yellow
set-location $site | out-null

write-host "Looking for $computerName in the SCCM console ..." -foregroundcolor yellow
$checkSCCM = [Boolean](get-cmdevice -name $computerName)

If ($checkSCCM -eq $True) {
  (Remove-CMDevice -DeviceName $computerName)
  write-host "$computerName was removed from SCCM" -foregroundcolor yellow
}
else {
  write-host "$computerName not in SCCM" -foregroundcolor red
}

# Change location back to local machine
set-location C: | out-null
