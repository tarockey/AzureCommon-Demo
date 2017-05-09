Login-AzureRmAccount

$subscriptionName = "your subscription name"

Select-AzureRMSubscription -SubscriptionName $subscriptionName

Get-AzureRmResourceGroup | Select ResourceGroupName, Location

$resourceGroupName = "export하려는 resource group 이름"

Export-AzureRMResourceGroup -ResourceGroupName $resourceGroupName -Path "C:\temp\$resourceGroupName.json"