
Login-AzureRmAccount

$subscriptionName = "your subscription name"

Select-AzureRmSubscription -SubscriptionName $subscriptionName

$reservedIpName = "MyReservedIP"
$location = "Central US"

New-AzureReservedIP –ReservedIPName $reservedIpName –Location $location

Get-AzureReservedIP

Remove-AzureReservedIP -ReservedIPName $reservedIpName -Force