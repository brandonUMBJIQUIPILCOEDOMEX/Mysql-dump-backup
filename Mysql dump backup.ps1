
Clear-Host
$xampp = "C:\xampp\mysql\bin\" 

If ((test-path $xampp)) {

    $PSDefaultParameterValues["Out-File:Encoding"] = "utf8"

    # Remove-Variable firefox  /= remover variables en powershell

    # ruta por defecto de mysql de xampp
    Set-Location -Path "C:\xampp\mysql\bin\" #-PassThru


    # Get-Process -Name ex*

    $ProcessCheck = Get-Process -Name mysqld -ErrorAction SilentlyContinue -ErrorVariable ProcessError
    if ($null -eq $ProcessCheck) {
        Write-output "mysqld no esta en ejecución"
        Write-Host "Iniciando mysqld......................"
        #start-Process ./mysqld.exe

    }
    else {
        Write-output "mysqld IS running"
    }


    # iniciar el proceso de mysql para las bases de datos
    $path = "C:\xampp\mysql\bin\mysqld.exe"

    get-process | where-object { $_.Path -eq $path } | measure-object | where-object { $_.Count -eq 0 } | foreach-object { start-process -filepath $path }


    if (Get-Process mysqld -ErrorAction silentlycontinue) {
        Write-Host "mysqld esta ejecutandose"

        $user = "root"
        $dbhost = "localhost"
        <# $password = "" #>
    
        $saveDBs = "$PSScriptRoot\bds\"
        
        get-process | where-object { $_.Path -eq $path } | measure-object | where-object { $_.Count -eq 0 } | foreach-object { start-process -filepath $path }
        
        
        If (!(test-path $saveDBs)) {
            mkdir $saveDBs 
        }
    
        # ruta dinamica creada para guardar las bases de datos
        $PATHOUT = $saveDBs
    
    
        <#
        $path = "C:\Users\admin\Desktop\ING MIGUEL SCRIPT\basesdedatos\"
        
    
        If (!(test-path $path)) {
            mkdir $path 
        }
        #>
        
        <# Clear-Host #>

        <# --comienza comentario #>
        
        Write-Host "`n/* ========== EXPORTING BD'S ========== /*`n"
   
        
        .\mysql.exe --host=localhost --user=root --password= --skip-column-names --execute="SELECT s.SCHEMA_NAME FROM information_schema.SCHEMATA s WHERE s.SCHEMA_NAME NOT IN ('
        mysql', 'information_schema', 'sys', 'performance_schema')" | Out-File "$PSScriptRoot\alldatabases.txt"
        

        foreach ($DBname in Get-Content "$PSScriptRoot\alldatabases.txt") {
        
            Write-Host "DATABASE = "$DBname

        
            Write-Host "Exportando .......................... $DBname"
         
           #  .\mysqldump.exe -h $dbhost -u $user $DBname > "$($PATHOUT)\$($DBname).sql"

            # .\mysqldump.exe -h $dbhost -u $user $DBname  > "$($PATHOUT)\$($DBname).sql"

           # .\mysqldump.exe -h $dbhost -u $user $DBname  --result-file="$($PATHOUT)\$($DBname).sql"
    
            if ((test-path "$($PATHOUT)\$($DBname).sql")) {
    
                Write-Host "$DBname exportada con exito`n"
            }
        
        }

        <# termina comentario #>
        
        Write-Host "`n/* ============= DONE...! ============= /*`n"

        


    }
    else {
        Write-Host "`n no se pudo iniciar el proceso mysqld"
    }


    # iniciamos el proceso de mysql 
    # .\mysqld.exe
    # "c:\temp\*.txt"
 

    # $files = Get-ChildItem  $saveDBs*.sql

    $files = @(Get-ChildItem $saveDBs*.sql)
    foreach ($file in $files) { $file }

    Write-Host "---> "$files.Count "Bases de datos encontradas"

    #  .\pscp.exe  -pw 123 brandon@192.168.2.73:$saveDBs*.sql C:/Users/brandon/Desktop/

    # PS> pscp paul@192.168.1.23:/home/paul/pscp-test.txt %USERPROFILE%\Documents\pscp-win.txt


    #Start-Process 'C:\Program Files\PuTTY\pscp.exe' -ArgumentList ("-scp -pw 123 %USERPROFILE%\Documents\ brandon@192.168.2.73:${saveDBs*.sql}")

    # Start-Process 'C:\Program Files\PuTTY\pscp.exe' -ArgumentList ("-scp -pw 123 ${saveDBs*.sql}  brandon@192.168.2.73:%USERPROFILE%\Documents", "pause")


    Write-Host "`n/* ============= ENVIANDO...! ============= /*`n"
    #EDYRISA

    $data= "C:\users\admin\Documents\"


    & "C:\Program Files\PuTTY\pscp.exe" -batch -scp -pw EDYRISA $data*.sql  HP@192.168.0.115:%USERPROFILE%\Music

    # ver posibilidad de poner pause para el error
    # Start-Process "C:\Program Files\PuTTY\pscp.exe" -ArgumentList ( '-scp -pw 123 $saveDBs*.sql  brandon@192.168.2.73:%USERPROFILE%\Documents')

    Write-Host "`n/* ============= DONE...! ============= /*`n"

    Set-Location -Path "C:\users\admin\Documents\"

    $dbds = "C:\users\admin\Documents\"










    

    Write-Host "`n/* ============= DONE...! ============= /*`n"
    Get-ChildItem $saveDBs\*.sql | Foreach-Object { "$_" }

    ansicon plink -t -batch -no-antispoof -ssh  HP@192.168.0.115 -pw EDYRISA "cd C:\users\HP\Music | powershell C:\users\HP\Music\import.ps1"
   # ansicon plink -t -batch -no-antispoof -ssh  HP@192.168.0.115 -pw EDYRISA "cd C:\users\HP\Music && echo "1" | powershell Write-Host HOLA PERROS"


}
elseif ((!test-path $xampp)) {
    Clear-Host
    Write-Host "`n === No se encontro una instalación de Xampp === `n"
}



