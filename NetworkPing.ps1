$network = arp -a | Out-File 'C:\Scripts\PowerShell\NetworkPing\ping.txt'

#$ips = Get-Content -Path 'C:\Scripts\PowerShell\NetworkPing\ping.txt' | gm

$regexIPAddress = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'

#Returns the first IP address in each line of the log file/s then sorts and removes duplicates.
Select-String -Path 'C:\Scripts\PowerShell\NetworkPing\ping.txt' -Pattern $regexIPAddress | ForEach-Object { $_.Matches } | % { $_.Value } | Sort-Object -Unique | Out-File 'C:\Scripts\PowerShell\NetworkPing\UniqueIPs.txt'

foreach ($ip in Get-Content -Path 'C:\Scripts\PowerShell\NetworkPing\UniqueIPs.txt') {
    Test-Connection -Ping -TargetName $ip
}