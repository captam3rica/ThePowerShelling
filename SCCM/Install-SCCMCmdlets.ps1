<#

ToDo ...

- Parse site info to grab site code

#>

# google sccm 2012 commandlet installer
# Open SCCM console
# Run PowerShell from console
# Run command get-cmsite

$sitepath = "[site code here]"

write-host "
##################################
####    SETUP SCCM CMDLETS    ####
##################################
" -forgroundcolor yellow

write-host "Cmdlet import about to begin ..." -foregroundcolor yellow
start-sleep -s 3

# Import SCCM cmdlets

cd 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\'
import-module .\ConfigurationManager.psd1 -verbose

# Check site info with cmdlet
# Will see errors because not connected to CM HD path. Will need to switch the path to the Config Manager site.

write-host ""
write-host "Testing the get-cmsite cmdlet. Receiving an error here is normal" -foregroundcolor yellow
write-host""

start-sleep -s 3
Get-CMSite

write-host "Changing to the Site path $sitepath ..." -foregroundcolor yellow
write-host ""
start-sleep -s 3
# Change to SITE Code
cd $sitepath
Get-CMSite

<#
BuildNumber       : 7958
Features          : 0000000000000000000000000000000000000000000000000000000000000000
InstallDir        : C:\Program Files\Microsoft Configuration Manager
Mode              : 0
ReportingSiteCode :
RequestedStatus   : 110
ServerName        : SDKTESTLAB.test.lab
SiteCode          : ABC
SiteName          : ABC Test Site
Status            : 1
TimeZoneInfo      : 000001E0 0000 000B 0000 0001 0002 0000 0000 0000 00000000 0000 0003 0000 0002 0002 0000 0000 0000
                    FFFFFFC4
Type              : 2
Version           : 5.00.7958.1000
#>
start-sleep -s 3

write-host "
##################################
#### UPDATE WIN PWRSHELL HELP ####
##################################
" -foregroundcolor yellow

write-host "Updating PowerShell help ..." -foregroundcolor yellow
write-host ""
start-sleep -s 3
update-help -module configurationmanager
get-help get-cmsite

write-host "Complete!!!" -foregroundcolor yellow
