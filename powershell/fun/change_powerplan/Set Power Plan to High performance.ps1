
Get-CimInstance -N root\cimv2\power -Class win32_PowerPlan | select ElementName, IsActive | ft -a

$p = Get-CimInstance -Name root\cimv2\power -Class win32_PowerPlan -Filter "ElementName = 'High Performance'"
Invoke-CimMethod -InputObject $p -MethodName Activate

#http://blogs.technet.com/b/heyscriptingguy/archive/2012/11/27/use-powershell-and-wmi-or-cim-to-view-and-to-set-power-plans.aspx