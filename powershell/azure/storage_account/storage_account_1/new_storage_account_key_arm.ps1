$resourceGroupName = "your resource group name"
$storageAccountName = "your storage account"

New-AzureRmStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName -KeyName key1
New-AzureRmStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName -KeyName key2