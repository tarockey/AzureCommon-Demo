
$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "vhds"

Set-AzureStorageContainerAcl -Context $ctx -Name $containerName -Permission Blob

Get-AzureStorageContainerAcl -Context $ctx -Name $containerName | SELECT Name, PublicAccess