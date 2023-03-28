
# Core settings - you will need to set these 
$mysql_server = "localhost"
$mysql_user = "username" 
$mysql_password = "password" 
$backupstorefolder= "E:\BackupPath\" 
$dbName = "wikidb"

# donde esta ubicado mysql de xampp
$pathtomysqldump = "C:\Program Files\MySQL\MySQL Server 5.1\bin\mysqldump.exe"

cls
# Determine Today´s Date Day (monday, tuesday etc)
$timestamp = Get-Date -format yyyyMMddHHmmss
Write-Host $timestamp 


