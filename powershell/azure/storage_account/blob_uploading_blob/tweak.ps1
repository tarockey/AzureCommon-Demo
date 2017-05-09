$storageAccountName = "your storage account name"

$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "images"

New-AzureStorageContainer -Context $ctx -Name $containerName -Permission Off

$dir = "C:\Users\jyseong\images"
$items = Get-ChildItem -Path $dir -File -Recurse

Set-Location -Path $dir

ForEach ($item in $items)
{
    $dest = $item | Resolve-Path -Relative 
    Set-AzureStorageBlobContent -Context $ctx -Container $containerName -File $item.FullName -Blob $dest -Force
   
}
