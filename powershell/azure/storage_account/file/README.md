# Azure PowerShell - File Storage 이용하기

Azure File Storage에 대해서는 다음의 자료를 참고하시기 바랍니다.

* [File Service Concepts](https://msdn.microsoft.com/library/dn166972.aspx)
* [Get started with Azure File storage](https://azure.microsoft.com/en-us/documentation/articles/storage-dotnet-how-to-use-files/)

## Azure File Share/Directory 생성하기

Azure File storage는 다음의 그림과 같이, Storage account > share > directory > file 등의 구성 요소로 이루어집니다.

![](https://docs.microsoft.com/en-us/azure/includes/media/storage-file-concepts-include/files-concepts.png)

참고 자료 : [File storage concepts](https://azure.microsoft.com/en-us/documentation/articles/storage-dotnet-how-to-use-files/#file-storage-concepts)

Storage account는 이미 생성이 되었으므로, 다음에는 Share와 Directory를 생성해야 합니다.

```powershell
$storageAccountName = "your storage account name"

$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key

$shareName = "myfileshare"
New-AzureStorageShare -Context $ctx -Name $shareName

$pathName = "images"
New-AzureStorageDirectory -Context $ctx -ShareName $shareName -Path $pathName 
```

Share는 New-AzureStorageShare cmdlet으로, Directory는 New-AzureStorageDirectory cmdlet으로 생성이 가능합니다.

참고 자료 :
* [New-AzureStorageShare](https://msdn.microsoft.com/en-us/library/dn806378.aspx)
* [New-AzureStorageDirectory](https://msdn.microsoft.com/en-us/library/mt603571.aspx)

## Azure File Share/Directory에 파일 올리기

이번에는 위에서 생성한 Azure file share의 directory에 파일을 업로드해보겠습니다.

blob를 blob storage로 업로드하는 방법과 유사하게, Azure file은 Set-AzureStorageFileContent cmdlet을 이용하면 됩니다.

```powershell
$storageAccountName = "your storage account name"

$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key

$shareName = "myfileshare"
$pathName = "images"
$sourceFile = "Azure subscription.png"

Set-AzureStorageFileContent -Context $ctx -ShareName $shareName -Path $pathName -Source .\images\$sourceFile 
```

참고 자료 : [Set-AzureStorageFileContent](https://msdn.microsoft.com/en-us/library/mt619400.aspx)

## Tweak - 로컬에 있는 폴더 전체를 Azure file에 올리기

blob에 폴더 전체를 올리는 방법과는 전혀 다른 방식을 사용해야 합니다.

다음의 스크립트를 참고하시기 바랍니다.

[Recursively upload a source folder to Azure File Storage](https://gallery.technet.microsoft.com/scriptcenter/Recursively-upload-a-bfb615fe)

## Azure File Share/Directory 삭제하기

Azure file directory는 Remove-AzureStorageDirectory cmdlet을
Azure file share는 Remove-AzureStorageShare cmdlet을 이용하여 삭제가 가능합니다.

```powershell
$storageAccountName = "your storage account name"

$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key

$shareName = "myfileshare"
$pathName = "images"

Remove-AzureStorageDirectory -Context $ctx -ShareName $shareName -Path $pathName 

Remove-AzureStorageShare -Context $ctx -Name $shareName -Force
```

참고 자료 :
* [Remove-AzureStorageDirectory](https://msdn.microsoft.com/en-us/library/dn806396.aspx)
* [Remove-AzureStorageShare](https://msdn.microsoft.com/en-us/library/mt619478.aspx)