$subscriptionName = "your subscription name"

Select-AzureRmSubscription -SubscriptionName $subscriptionName

$storageAccountName = "your storage account name"

(Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary
(Get-AzureStorageKey -StorageAccountName $storageAccountName).Secondary
