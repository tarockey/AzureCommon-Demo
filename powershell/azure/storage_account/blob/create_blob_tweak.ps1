
Set-AzureSubscription -SubscriptionName $subscriptionName -CurrentStorageAccountName $storageAccountName 

Get-AzureSubscription -SubscriptionName $subscriptionName 

$containerName = "default"

New-AzureStorageContainer -Name $containerName -Permission Off 

Get-AzureStorageContainer | SELECT Name, PublicAccess | Format-Table

(Get-AzureStorageContainer ).Context.StorageAccountName