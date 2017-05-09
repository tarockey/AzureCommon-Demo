# Azure PowerShell - Blob 이용하기

이번에는 blob container에 있는 blob 파일 또는 파일들의 목록을 반환하는 cmdlet과 blob 파일을 삭제하는 방법에 대해서 살펴 하겠습니다.

## Blob 파일/목록 가져오기

blob 파일 정보를 가져오는 작업은 ASM, ARM 모두 동일하게 Get-AzureStorageBlob cmdlet을 사용합니다(앞서 살펴본 것처럼, ASM, ARM의 차이는 storage account의 key를 반환하는 방식에 차이만 있습니다).

스크립트는 다음과 같습니다(ARM 방식을 사용하는 예제입니다). 

```powershell
$resourceGroupName = "your resource group name"
$location = "East Asia" 
$storageAccountName = "your storage account"

$key = (Get-AzureRmStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName).Value[0]
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "images"

Get-AzureStorageBlob -Context $ctx -Container $containerName
```

지정된 Storage account의 context와 container에 있는 모든 blob 파일 목록을 반환하게 됩니다.

특정 blob 파일만 반환하려면, ___-Blob___ 매개 변수에 찾고자 하는 파일 이름을 지정하면 됩니다.

```powershell
Get-AzureStorageBlob -Context $ctx -Container $containerName -Blob "PNG/CnE_Cloud/Azure SQL Database.png"
```

참고 자료 : [Get-AzureStorageBlob](https://msdn.microsoft.com/en-us/library/mt603751.aspx)

## Blob 삭제하기

blob의 삭제는 Remove-AzureStorageBlob cmdlet을 이용합니다.

```powershell
$resourceGroupName = "your resource group name"
$location = "East Asia" 
$storageAccountName = "your storage account"

$key = (Get-AzureRmStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName).Value[0]
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "images"

Remove-AzureStorageBlob -Context $ctx -Container $containerName -Blob "PNG/CnE_Cloud/Azure subscription.png"
```

___-Context___ 는 storage account의 context를 

___-Container___ 는 삭제하려는 blob이 있는 container를

___-Blob___ 은 삭제하려는 blob 파일을 지정합니다.

다음과 같이, Get-AzureStorageBlob cmdlet과 함께 사용하여, 검색된 파일을 삭제하는 것도 가능합니다.

```PowerShell
Get-AzureStorageBlob -Context $ctx -Container $containerName -Blob "PNG/CnE_Cloud/Azure SQL Database.png" | Remove-AzureStorageBlob 
```

위의 방법을 조금 더 확장하여 사용하면, 한번의 명령 실행 만으로 Container에 있는 모든 파일들을 삭제할 수 있습니다.

```powershell
Get-AzureStorageBlob -Context $ctx -Container $containerName | Remove-AzureStorageBlob 
```

참고 자료 : [Remove-AzureStorageBlob](https://msdn.microsoft.com/en-us/library/dn806399.aspx)


## Blob 다운로드 하기

blob 파일을 로컬로 다운로드하는 cmdlet은 Get-AzureStorageBlob입니다.

blob를 삭제하는 방법과 마찬가지로, 복사할 blob를 해당 cmdlet에서 직접 지정을 하거나(아래의 스크립트에서는 $localPath라는 새로운 매개 변수가 추가되었습니다. blob를 다운로드할 로컬의 경로를 지정하면 됩니다)

```powershell
$storageAccountName = "your storage account name"

$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "images"

$localPath = "C:\temp\images\"

Get-AzureStorageBlobContent -Context $ctx -Container $containerName -Blob "PNG/CnE_Cloud/Data Factory.png" -Destination $localPath
```

Get-AzureStorageBlob cmdlet을 이용하여 blob을 검색한 결과를 Get-AzureStorageBlobContent cmdlet에게 pipe로 연결하여 개체를 전달하는 방식을 사용할 수 있습니다.

```powershell
Get-AzureStorageBlob -Context $ctx -Container $containerName -Blob "PNG/CnE_Cloud/GitHub.png" | Get-AzureStorageBlobContent -Destination $localPath 
```

삭제 방법과 마찬가지로, 한번의 명령으로 특정 container의 모든 blob들을 로컬로 다운로드 할 수 있습니다.

```powershell
Get-AzureStorageBlob -Context $ctx -Container $containerName | Get-AzureStorageBlobContent -Destination $localPath 
```

참고 자료 : [Get-AzureStorageBlobContent](https://msdn.microsoft.com/en-us/library/mt603508.aspx)