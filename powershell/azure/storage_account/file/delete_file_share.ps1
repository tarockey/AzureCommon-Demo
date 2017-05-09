$storageAccountName = "your storage account name"

$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key

$shareName = "myfileshare"
$pathName = "images"

Remove-AzureStorageDirectory -Context $ctx -ShareName $shareName -Path $pathName 

Remove-AzureStorageShare -Context $ctx -Name $shareName -Force