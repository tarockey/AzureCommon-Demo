# External IP Address
(Invoke-WebRequest ifconfig.me/ip).Content

# ipconfig
Get-NetIPAddress
Get-NetIPAddress|Format-Table