$storageAccountName = "your storage account"

$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "images"

New-AzureStorageContainer -Context $ctx -Name $containerName -Permission Off

$fileName = "Azure subscription.png"

Set-AzureStorageBlobContent -Context $ctx -Container $containerName -File .\images\$fileName -Blob $fileName 