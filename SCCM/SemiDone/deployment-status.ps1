<#

This script gets the deployment status of a ConfigMgr 2012 Package or Task Sequence

#>

$Name = "LAB - ECET (Fall 2017)" # Enter Package or Task Sequence Name
$CSV = "No" # Output to CSV, Yes or No
$Grid = "Yes" # Out-Gridview, Yes or No
# Get Start Time
$startDTM = (Get-Date)

# Database info
$dataSource = “labsccm-lab1.lab.kennesaw.edu\CM_LB1”
$database = “CM_LB1”

# Open a connection
cls
Write-host "Opening a connection to '$database' on '$dataSource'"
#Using windows authentication, or..
$connectionString = “Server=$dataSource;Database=$database;Integrated Security=SSPI;”
# Using SQL authentication
#$connectionString = "Server=$dataSource;Database=$database;uid=ConfigMgrDB_Read;pwd=Pa$$w0rd;Integrated Security=false"
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$connection.Open()

# Getting Package / TS deployment status
Write-host "Running query..."

$query = "
select PackageName as 'Package / Task Sequence',ai.AdvertisementID as 'DeploymentID',ai.CollectionName, Name0 as 'Computer Name', User_Name0 as 'User Name', LastAcceptanceMessageIDName, LastAcceptanceStateName, LastAcceptanceStatusTime, LastStatusMessageIDName, LastStateName, LastStatusTime, LastExecutionResult
from v_ClientAdvertisementStatus cas
inner join v_R_System sys on sys.ResourceID=cas.ResourceID
inner join v_AdvertisementInfo ai on ai.AdvertisementID=cas.AdvertisementID
where PackageName = '$Name' and LastStatusTime is not null ORDER BY LastStatusTime Desc
"
$command = $connection.CreateCommand()
$command.CommandText = $query
$result = $command.ExecuteReader()

$table = new-object “System.Data.DataTable”
$table.Load($result)
$Count = $table.Rows.Count

if ($CSV -eq "Yes")
{
$Date = Get-Date -Format HH-mm--dd-MMM-yy
$Path = "C:\Script_Files\SQLQuery-$Date.csv"
$table | Export-Csv -Path $Path
Invoke-Item -Path $Path
}
If ($Grid -eq "Yes")
{
$table | Out-GridView -Title "Deployment Status of '$Name' ($count machines)"
}
# Close the connection
$connection.Close()

# Get End Time
$endDTM = (Get-Date)

# Echo Time elapsed
"Elapsed Time: $(($endDTM-$startDTM).totalseconds) seconds"
