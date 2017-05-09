$storageAccountName = "your storage account name"

$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key

$shareName = "myfileshare"
New-AzureStorageShare -Context $ctx -Name $shareName

$pathName = "images"
New-AzureStorageDirectory -Context $ctx -ShareName $shareName -Path $pathName 