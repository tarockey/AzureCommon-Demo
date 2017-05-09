# Azure PowerShell - Blob 이용하기 

이번에는 blob container에 파일을 올려보도록 하겠습니다.

## Blob에 파일 올리기

blob에 파일을 올리는 작업은 ASM, ARM 모두 동일하게 Set-AzureStorageBlobContent cmdlet을 사용합니다(앞서 살펴본 것처럼, ASM, ARM의 차이는 storage account의 key를 반환하는 방식에 차이만 있습니다).

스크립트는 다음과 같습니다(ARM 방식을 사용하는 예제입니다). 

```powershell
$resourceGroupName = "your resource group name"
$location = "East Asia" 
$storageAccountName = "your storage account"

$key = (Get-AzureRmStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName).Value[0]
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "images"

New-AzureStorageContainer -Context $ctx -Name $containerName -Permission Off

$fileName = "Azure subscription.png"

Set-AzureStorageBlobContent -Context $ctx -Container $containerName -File .\images\$fileName -Blob $fileName 
```

Set-AzureStorageBlobContent에서 사용된 매개변수는 다음과 같습니다.

___-Context $ctx___ 는 이미 설명된 것처럼, 작업하려는 storage account에 대한 context입니다.

___-Container $containerName___ 는 파일을 올리려는 container의 이름입니다.

___-File .\images\$fileName___ 는 올리려는 파일을 지정하면 됩니다. 파일의 경로는 절대 경로는 물론이고, 상대 경로도 사용이 가능합니다. 여기서는 상대 경로(.\images\$fileName)를 사용하였습니다.

___-Blob $fileName___ 는 blob으로 저장될 때의 파일 이름을 지정합니다. 통상 원본 파일과 동일한 이름을 지정하지만, 필요에 따라서는 다른 명명 규칙(naming rule)이 필요한 경우에는 다른 이름으로 지정을 하면 됩니다.

스크립트를 실행한 결과는 다음과 같습니다.

![](https://jyseongfileshare.blob.core.windows.net/images/storage_account-09.png)

## Tweak - 로컬에 있는 폴더 전체를 blob에 올리기

단일 파일을 blob에 올리는 경우도 있지만, 많은 파일들을 blob에 하위 디렉터리와 함께 올려야 하는 경우가 있습니다.

이 경우에는 다음의 스크립트를 이용하면 됩니다.

```powershell
$dir = "C:\Users\jyseong\images"
$items = Get-ChildItem -Path $dir -File -Recurse

Set-Location -Path $dir

ForEach ($item in $items)
{
    $dest = $item | Resolve-Path -Relative 
    Set-AzureStorageBlobContent -Context $ctx -Container $containerName -File $item.FullName -Blob $dest -Force
   
}
```

blob으로 올리려는 로컬의 경로를 $dir 변수에 할당하여 사용하면 됩니다.