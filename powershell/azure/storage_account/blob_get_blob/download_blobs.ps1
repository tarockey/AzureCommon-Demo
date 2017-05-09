$storageAccountName = "your storage account name"

$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "images"

$localPath = "C:\temp\images\"

Get-AzureStorageBlobContent -Context $ctx -Container $containerName -Blob "PNG/CnE_Cloud/Data Factory.png" -Destination $localPath

Get-AzureStorageBlob -Context $ctx -Container $containerName -Blob "PNG/CnE_Cloud/GitHub.png" | Get-AzureStorageBlobContent -Destination $localPath 

Get-AzureStorageBlob -Context $ctx -Container $containerName | Get-AzureStorageBlobContent -Destination $localPath 