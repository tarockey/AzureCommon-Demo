Set-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -SkuName Standard_GRS

(Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName).Sku.Name
