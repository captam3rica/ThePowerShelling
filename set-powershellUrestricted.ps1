# Set powershell run-level to Unrestricted

$RunLevel = Get-ExecutionPolicy

If ($RunLevel -eq "Unrestricted" -or $RunLevel -eq "RemoteSigned"){
  write-host "The locacal EXECUTION POLICY is set to $RunLevel already!!!!!"
}
else {
  write-host "Setting PowerShell run-level to Unrestricted ..." -foregroundcolor yellow
  set-executionpolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force
  exit
}
