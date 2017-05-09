# Azure PowerShell - Storage Account > Blob 관리

아래의 예제는 Storage account가 미리 생성되어 있어야 합니다.

Azure Storage Account를 생성하는 방법에 대해서는 ["Azure PowerShell - Storage Account > 생성/수정/삭제"](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/storage_account_basic)을 참고하시기 바랍니다.

Azure Storage account의 Blob 서비스에 대해서는 [Get started with Azure Blob](https://azure.microsoft.com/en-us/documentation/articles/storage-dotnet-how-to-use-blobs/)를 참고하시기 바랍니다.

## Blob container 만들기 

Azure Storage account의 blob 서비스에 파일은 container에 저장이 이루어집니다.

따라서, Azure Storage account를 생성한 이후에는 container를 생성해 주어야 하며, 생성 방법은 다음과 같습니다.

container 생성을 위해서는 Storage account의 context가 필요하며(New-AzureStorageContext), context는 Storage account에서 제공되는 키가 필요합니다. 

따라서, 먼저 container를 생성하기 위해서는

1. Storage account의 key를 반환
2. 반환된 key를 이용하여 storage account의 context를 반환
3. container 생성

의 순서에 따라서 작업이 이루어져야 합니다.

#### Azure Service Management(Classic)

Azure Service Management(Classic)에서 container를 생성하는 과정은 다음과 같습니다.

1. Storage account의 key를 반환 > [Get-AzureStorageKey](https://msdn.microsoft.com/en-us/library/azure/dn495235.aspx)
2. 반환된 key를 이용하여 storage account의 context를 반환 > [New-AzureStorageContext](https://msdn.microsoft.com/en-us/library/mt603703.aspx)
3. container 생성 > [New-AzureStorageContainer](https://msdn.microsoft.com/en-us/library/mt619462.aspx)

```powershell
$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "vhds"

New-AzureStorageContainer -Context $ctx -Name $containerName -Permission Off 
```

여기서, container의 이름은 "vhds"로 하였습니다.

해당 container에 대한 액세스 정책(-Permission)은 off로 설정을 하였습니다.

액세스 정책(-Permission)에 설정할 수 있는 값들은 다음과 같습니다. 

실제 포털에서 사용되는 용어와 다릅니다. 실제 포털에서 사용되는 용어와 각각의 설명은 다음과 같습니다.

* Full public read access
  * PowerShell : Blob
  * 포털 : Blob
  * 별다른 보안 키나 인증이 없이 접근이 가능합니다.
* Public read access for blobs only
  * PowerShell : Container
  * 포털 : Container
  * 컨테이너 내의 blob에 대해서만 접근이 가능합니다. 
  * Blob 와 container의 차이는 [Features available to anonymous users](https://azure.microsoft.com/en-us/documentation/articles/storage-manage-access-to-resources/#features-available-to-anonymous-users)를 참고하시기 바랍니다.
* No public read access
  * PowerShell : __Off__
  * 포털 : __Private__
  * 인증 정보나 보안 키가 없는 경우에는 접근 불가.

액세스 정책에 대해서는 [Manage anonymous read access to containers and blobs](https://azure.microsoft.com/en-us/documentation/articles/storage-manage-access-to-resources/)를 참고하시기 바랍니다.

#### Azure Resource Manager(ARM)

Azure Resource Manager(ARM)에서 container를 생성하는 과정은 다음과 같습니다.

1. Storage account의 key를 반환 > [Get-AzureRmStorageAccountKey](https://msdn.microsoft.com/en-us/library/mt607145.aspx)
2. 반환된 key를 이용하여 storage account의 context를 반환 > [New-AzureStorageContext](https://msdn.microsoft.com/en-us/library/mt603703.aspx)
3. container 생성 > [New-AzureStorageContainer](https://msdn.microsoft.com/en-us/library/mt619462.aspx)

```powershell
$key = (Get-AzureRmStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName).Value[0]
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "vhds"

New-AzureStorageContainer -Context $ctx -Name $containerName -Permission Off 
```

ASM과 ARM이 다른 점은 Key를 가져오는 cmdlet에 있습니다.

여기서 .Value[0]는 Primary access key를 의미합니다.

![](https://jyseongfileshare.blob.core.windows.net/images/storage_account-08.png)


## Tweak

Subscription에 대한 기본 Storage account가 설정되어 있는 경우에는 context를 생성할 필요가 없습니다.

기본적으로  Subscription을 생성하면, 다음의 그림과 같이 subscription의 CurrentStorageAccountName이 설정되어 있지 않습니다.

![](https://jyseongfileshare.blob.core.windows.net/images/storage_account-04.png)

subscription에 CurrentStorageAccountName을 설정하는 방법은 다음과 같습니다.

CurrentStorageAccountName를 설정하고, 적용이 완료된 설정을 확인은 다음의 스크립트로 가능합니다.

```powershell
Set-AzureSubscription -SubscriptionName $subscriptionName -CurrentStorageAccountName $storageAccountName 

Get-AzureSubscription -SubscriptionName $subscriptionName 
```

실행된 결과를 보면, 앞서 생성하였던 Storage account가 CurrentStorageAccountName로 설정된 것을 볼 수 있습니다.

![](https://jyseongfileshare.blob.core.windows.net/images/storage_account-05.png)


이제, context 매개변수를 제외한 New-AzureStorageContainer cmdlet을 실행시켜 보도록 하겠습니다.

이번에는 container의 이름은 "default"라고 지정하여 생성해보고, 생성된 container의 목록을 반환하여 보도록 하겠습니다.

```powershell
$containerName = "default"

New-AzureStorageContainer -Name $containerName -Permission Off 

Get-AzureStorageContainer | SELECT Name, PublicAccess | Format-Table
```

앞선 구문들과는 달리, 위의 구문에는 -Context 매개변수를 명시하지 않았습니다.

이런 경우에는, 해당 Subscription의 CurrentStorageAccountName로 설정된 storage account에 container가 생성됩니다.

![](https://jyseongfileshare.blob.core.windows.net/images/storage_account-06.png)

## Blob container 목록 가져오기

Blob container 목록을 가져오는 방법은 이미 바로 위에서 설명이 되었습니다. 앞서는 해당 subscription의 기본 storage account의 container를 반환하였습니다만, 이번에는 다른 Storage account의 container 목록을 반환하는 방법입니다.

예상하신 것처럼, 기본 storage account가 아닌, 다른 storage account는 context가 필요합니다.

다음과 같이 사용할 수 있습니다. ASM(Class), ARM 모두 동일한 cmdlet을 사용합니다.

```powershell
$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key

Get-AzureStorageContainer -Context $ctx 
```

참고 자료 : [Get-AzureStorageContainer](https://msdn.microsoft.com/en-us/library/mt603628.aspx)

## Blob container의 액세스 정책 변경하기

이번에는 앞서 생성한 container의 액세스 정책을 변경하는 방법에 대해서 살펴봅니다.

이미 살펴본 것처럼, container 작업을 위해서는 context가 필요합니다. 다음과 같이 변경이 가능합니다.

아래의 스크립트에서는 액세스 정책을 Blob로 변경하고 있습니다.

```powershell
$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "vhds"

Set-AzureStorageContainerAcl -Context $ctx -Name $containerName -Permission Blob

Get-AzureStorageContainerAcl -Context $ctx -Name $containerName | SELECT Name, PublicAccess
```

스크립트를 실행하면, container의 액세스 정책을 변경하고(Set-AzureStorageContainerAcl), container의 정보를 반환(Get-AzureStorageContainerAcl)합니다.

![](https://jyseongfileshare.blob.core.windows.net/images/storage_account-07.png)

참고 자료 : [Set-AzureStorageContainerAcl](https://msdn.microsoft.com/en-us/library/mt603534.aspx)

## Blob container 삭제하기

마지막으로 blob container를 삭제합니다. blob container 삭제는 Remove-AzureStorageContainer cmdlet을 이용하여야 합니다.

스크립트는 다음과 같습니다.

```powershell
$key = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Secondary 
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$containerName = "vhds"

Remove-AzureStorageContainer -Context $ctx -Name $containerName
```

참고 자료 : [Remove-AzureStorageContainer](https://msdn.microsoft.com/en-us/library/dn806389.aspx)