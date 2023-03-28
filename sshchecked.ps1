<#


Write-Host "Checking for elevated permissions..."
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
            [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Insufficient permissions to run this script. Open the PowerShell console as an administrator and run this script again."
    Start-Process Powershell -ArgumentList $PSCommandPath -Verb RunAs
   # Break 
}
else {
    Write-Host "Code is running as administrator go on executing the script" 

   

}

#>


param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent()) 
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator) 
}

Write-Host "Checking for elevated permissions..."

if ((Test-Admin) -eq $false) {
    if ($elevated) {  
        Write-Host "Code is running as administrator go on executing the script" 

    }
    else {
        Write-Warning "Abriendo powershell como administrador"
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition)) 
    } 
    exit 
}






Set-Location -Path "C:\Windows\system32\"
$ps = Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*' | Select-Object Name, State | ForEach-Object { $_.Name, $_.State }
$ps[0]
$ps[1]
Write-Host ""

if ($ps[0] -like 'OpenSSH.Client*' -and $ps[1] -eq 'Installed') {
    Write-Warning  "Esta instalado ssh cliente"
}
elseif (($ps[0] -like 'OpenSSH.Client*' -or $ps[0] -eq 'OpenSSH.Client~~~~0.0.1.0' ) -and $ps[1] -eq 'NotPresent') {
    Write-Host "No esta instalado ssh cliente"
    # aqui instalamos y levantamos los servicios de SSH CLIENTE
}

if (($ps[2] -like 'OpenSSH.Server*' -or $ps[2] -eq 'OpenSSH.Server~~~~0.0.1.0') -and $ps[3] -eq 'Installed') {
    Write-Warning  "Esta instalado ssh Server"
}
elseif ($ps[2] -like 'OpenSSH.Server*' -and $ps[3] -eq 'NotPresent') {
    Write-Warning  "No esta instalado ssh Server"
    # aqui instalamos y levantamos los servicios de SSH SERVER
}


if ((Get-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0).State -eq 'Installed') { Write-Host "Server is Installed..!"}



Write-Host ""
$ps[2]
$ps[3]


#Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*' | Select-Object Name, State | ForEach-Object { $_.Name + " " + $_.State }
Pause
exit
# despues del pause programar un script





