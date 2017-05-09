$subscriptionName = "your subscription name"

Select-AzureRmSubscription -SubscriptionName $subscriptionName

$storageAccountName = "your storage account name"

New-AzureStorageKey -StorageAccountName $storageAccountName -KeyType Primary
New-AzureStorageKey -StorageAccountName $storageAccountName -KeyType Secondary