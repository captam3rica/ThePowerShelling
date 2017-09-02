#Requires -RunASAdministrator

###################################################################
###################################################################
## Script to download and install RSAT
##
## Updated: 09.01.2017
##
## By: Matt Wilson aka captam3rica
##
## Must run this script as an Amdin or from
## an admin console.
##
## ByPass PowerShell restrictions
## Get-Content .runme.ps1 | PowerShell.exe -noprofile -
##
## Run script with another runlevel
## temporarily.
## PowerShell.exe -ExecutionPolicy Remote-signed -File .runme.ps1
###################################################################
###################################################################

##############################
##   CHECK POWERSHELL ENV   ##
##############################

If ($PSVersionTable.PSVersion -lt "3.0"){
  write-host "Please upgrade PowerShell to version 3.0 or higher ..." -foregroundcolor yellow
  break
}

# Set powershell run-level
$RunLevel = Get-ExecutionPolicy
If ($RunLevel -ne "Unrestricted" -Or $RunLevel -ne "RemoteSigned"){
  write-host "Setting PowerShell run-level to Unrestricted ..." -foregroundcolor yellow
  set-executionpolicy Unrestricted
}

##############################
##       MAIN SCRIPT        ##
##############################

$user=$env:username
$MachineOS=(Get-WmiObject Win32_OperatingSystem).Name
$arch=$ENV:PROCESSOR_ARCHITECTURE
$url=Invoke-WebRequest https://www.microsoft.com/en-us/download/confirmation.aspx?id=45520

# Parse the downloaded file
$NewURL = (($url.AllElements |where class -eq "multifile-failover-url").innerhtml[0].split(" ")|select-string href).tostring().replace("href=","").trim('"')

# Download path variable
$DownPath = ($ENV:USERPROFILE) + "\Desktop\" + ($NewURL.split("/")[8])

# Download RSAT installer
write-host "Downloading Microsoft RSAT file ..." -foregroundcolor yellow
Start-BitsTransfer -Source $NewURL -Destination $DownPath

# Check for file authenticity
$AuthFile = Get-AuthenticodeSignature $DownPath

If ($AuthFile.status -ne "valid"){
  write-host "Unable to varify download, exiting ..." -foregroundcolor yellow
  break
}

# Insatall RSAT for Win10
Write-host "Installing RSAT for Windows 10. Please wait ..." -foregroundcolor yellow
Start-Process -FilePath "C:\Windows\System32\wusa.exe" -ArgumentList $DownPath -Wait

# Import active directory & group policy modules
# Import-Module -Name ActiveDirectory; Import-Module -Name GroupPolicy;
