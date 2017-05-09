
$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "vhds"

New-AzureStorageContainer -Context $ctx -Name $containerName -Permission Off