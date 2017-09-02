# Pulls the UUID, and other info, For the local machine

# http://windowsitpro.com/powershell/powershell-basics-filtering-objects

("")
write-output "Computer Information ..."
("")

(get-wmiobject -Class Win32_ComputerSystem -Property Name).Name
(get-wmiobject Win32_ComputerSystemProduct).UUID
(Get-NetIPAddress -AddressState Preferred -AddressFamily IPv4 | where-object {$_.IPAddress -ne '127.0.0.1'}).IPAddress
("")
