$storageAccountName = "your storage account name"

$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key

$shareName = "myfileshare"
$pathName = "images"
$sourceFile = "Azure subscription.png"

Set-AzureStorageFileContent -Context $ctx -ShareName $shareName -Path $pathName -Source .\images\$sourceFile 