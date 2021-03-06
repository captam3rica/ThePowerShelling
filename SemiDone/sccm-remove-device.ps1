#Requires -RunAsAdministrator

# Removes a device from SCCM console
#[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact="Medium")]

# Load InputBox
[void][system.reflection.assembly]::loadwithpartialname('Microsoft.VisualBasic')

$site = [Microsoft.VisualBasic.interaction]::inputbox('Enter CM Site Code','Site?') + ":"

# Load InputBox
[void][system.reflection.assembly]::loadwithpartialname('Microsoft.VisualBasic')

$computerName = [Microsoft.Visualbasic.interaction]::inputbox('Enter a computer name','Computer?')

# Check to see if device exists in Console
cls
write-host "Changing location to $site ..." -foregroundcolor yellow
set-location $site | out-null

write-host "Looking for $computerName in the SCCM console ..." -foregroundcolor yellow
$checkSCCM = [Boolean](get-cmdevice -name $computerName)

If ($checkSCCM -eq $True) {
  (Remove-CMDevice -DeviceName $computerName -confirm)
  write-host "$computerName was removed from SCCM" -foregroundcolor yellow
}
else {
  write-host "$computerName not in SCCM" -foregroundcolor red
}

# Change location back to local machine
set-location C: | out-null
