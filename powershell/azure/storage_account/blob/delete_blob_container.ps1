
$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Secondary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "vhds"

Remove-AzureStorageContainer -Context $ctx -Name $containerName