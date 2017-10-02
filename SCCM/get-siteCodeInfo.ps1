#Requires -RunAsAdministrator

#########################
## Get-SiteInformation ##
#########################

Get-WmiObject -ComputerName "<your_site_server>" -Namespace "root\sms" -Class "SMS_ProviderLocation"
