$name = 'powershell_ise'
$count=0
foreach($procesoid in (Get-Process -Name $name).Id){
$count+=((Get-WmiObject -Class Win32_Thread).where{$_.ProcessHandle -match $procesoid}).count
Write-Host 'PID:' $procesoid 'process' $name 'threads:' $count
$count=0
}

