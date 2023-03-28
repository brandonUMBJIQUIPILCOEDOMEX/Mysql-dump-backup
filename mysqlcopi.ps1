
#
# ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── I ──────────
#   :::::: B A C K U P I N G   W I T H   P O W E R S H E L L   A N D   M Y S Q L D U M P : :  :   :    :     :        :          :
# ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
#
#
# ─── VARIABLES ──────────────────────────────────────────────────────────────────
#

 cd "c:\Program Files\MySQL\MySQL Server 5.7\bin"

$dbUser     ="root"
$dbPassword ="root"
$dbHost     ="localhost"
$dbName     ="test"
#
# ─── DATE WITH FORMAT TO ADD A OUT SQL FILE ─────────────────────────────────────
#
$ACTUAL_DATE = Get-Date -Format "dd-MM-yyyy hh.mm.ss"
#
# ─── GETTING THE NAME OF THE OUT SQL FILE TO BACKUP ─────────────────────────────
#
$PATH_DBNAME_BAKUP ="C:\BACKUP\DBNAME\"
$FILE_NAME_BACKUP_DBNAME ="DBNAMEdump_"
$FILE_BACKUP_DBNAME = Join-Path  -Path $PATH_DBNAME_BAKUP -ChildPath $FILE_NAME_BACKUP_DBNAME
#
# ─── INVOKING THE COMPLETE COMMAND ──────────────────────────────────────────────
#
#mysqldump.exe -h $dbHost -u $dbUser -p $dbPassword $dbName > $FILE_BACKUP_DBNAME.$ACTUAL_DATE.sql

.\mysqldump.exe -h $dbHost -u $dbUser -p  $dbName > "$($FILE_BACKUP_DBNAME)\$($ACTUAL_DATE).sql"