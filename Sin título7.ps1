Set-Location -Path "C:\xampp\mysql\bin\" -PassThru



.\mysql.exe --host=localhost --user=root --password= --skip-column-names --execute="SELECT s.SCHEMA_NAME FROM information_schema.SCHEMATA s WHERE s.SCHEMA_NAME NOT IN ('
mysql', 'information_schema', 'sys', 'performance_schema')" | Out-File "C:\Users\admin\Desktop\ING MIGUEL SCRIPT\alldatabases.txt"

foreach($DBname in Get-Content "C:\Users\admin\Desktop\ING MIGUEL SCRIPT\alldatabases.txt")
{ $DBname
<#
Write-Host $DBname
&"C:\Program Files\Devart\dbForge Studio for MySQL\dbforgemysql.com" /backup /connection:"User Id=root;Password=root;Host=localhost;Port=3306;Character Set=utf8" /database:$DBname /outputfile:"D:\backup\all_databases_backup\PowerShell\all_DB_backup\$DBname.sql" #>}