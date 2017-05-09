$resourceGroupName = "your resource group name"
$location = "East Asia" 
$storageAccountName = "your storage account"

$key = (Get-AzureRmStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName).Value[0]
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "images"

Get-AzureStorageBlob -Context $ctx -Container $containerName

Get-AzureStorageBlob -Context $ctx -Container $containerName -Blob "PNG/CnE_Cloud/Azure SQL Database.png"