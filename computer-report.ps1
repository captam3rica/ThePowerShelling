$Path = "$env:userprofile\Desktop\computer_info.txt"

Get-CimInstance Win32_OperatingSystem | Select-Object  Caption, InstallDate, BuildNumber, CSName | FL | Out-File -filepath $Path
Get-WmiObject Win32_Computersystem |  Format-List Model | FL | Out-File -filepath $Path -Append

$myProcessor = (Get-WmiObject -class win32_processor).name | Out-File -filepath $Path -Append

$PhysicalMemory = Get-WmiObject CIM_PhysicalMemory | Measure-Object -Property capacity -Sum | % {[math]::round(($_.sum / 1GB),2)}  | Out-File -filepath $Path -Append

$firmware = Get-WmiObject Win32_PnPSignedDriver| select devicename, driverversion  | Out-File -filepath $Path -Append

# $errors = Get-WmiObject -Class Win32_PNPEntity | Where-Object {($_.Name -match "Surface|Marvell|Intel|Nvidia|Realtek|Camera") -and ($_.ConfigManagerErrorCode -ne "0")} | Select-ObjectCaption,ConfigManagerErrorCode,Present,Status | Out-File -filepath $Path -Append

Get-HotFix -ComputerName "." | Out-File -filepath $Path -Append
