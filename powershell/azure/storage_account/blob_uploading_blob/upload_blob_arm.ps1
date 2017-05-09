$resourceGroupName = "your resource group name"
$location = "East Asia" 
$storageAccountName = "your storage account name"

$key = (Get-AzureRmStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName).Value[0]
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "images"

New-AzureStorageContainer -Context $ctx -Name $containerName -Permission Off

$fileName = "Azure subscription.png"

Set-AzureStorageBlobContent -Context $ctx -Container $containerName -File .\images\$fileName -Blob $fileName 

#recursive
https://gallery.technet.microsoft.com/scriptcenter/Recursively-upload-a-bfb615fe