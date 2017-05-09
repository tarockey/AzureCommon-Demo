Set-AzureStorageAccount -StorageAccountName $storageAccountName -Type Standard_GRS -Label "LRS"

Get-AzureStorageAccount -StorageAccountName $storageAccountName