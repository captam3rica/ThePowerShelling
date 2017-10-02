#Requires -RunAsAdministrator

##########################################################################
#
# Removes a device from SCCM console
#[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact="Medium")]
#
##########################################################################


# Load InputBox
[void][system.reflection.assembly]::loadwithpartialname('Microsoft.VisualBasic')

$site = [Microsoft.VisualBasic.interaction]::inputbox('Enter CM Site Code "ie SITE1"','Site?') + ":"

$computerName = [Microsoft.Visualbasic.interaction]::inputbox('Enter a computer name','Computer?')

# Check to see if device exists in Console
cls
write-host "Changing location to $site ..." -foregroundcolor yellow
set-location $site | out-null

write-host "Looking for $computerName in the SCCM console ..." -foregroundcolor yellow
$checkSCCM = get-cmdevice -name $computerName
#$checkSCCM = [Boolean](get-cmdevice -name $computerName)

Foreach ($item in $checkSCCM)
{
  $computer = $item.Name
  $userInput = Read-Host "Would you like to remove $computer ? [Y/n]"

  if ($userInput -eq "Y")
  {
    Remove-CMDevice -Force -DeviceName $computer
    write-host "$computer was removed from SCCM" -foregroundcolor green
  }

  else
  {
    write-host "$computer was not removed from SCCM" -foregroundcolor red
  }
}

[Microsoft.VisualBasic.Interaction]::MsgBox("Computer(s) have been removed!!!",
"OKOnly,SystemModal,Information", "Success")

If ($checkSCCM.length -eq 0)
{
  write-host "$computer not in SCCM" -foregroundcolor red

  [Microsoft.VisualBasic.Interaction]::MsgBox("Computer not in SCCM ...",
  "OKOnly,SystemModal,Information", "Success")
}

# Change location back to local machine
set-location C: | out-null
