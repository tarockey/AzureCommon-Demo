# Azure PowerShell - Storage Account 

## Storage Account key 가져오기

Storage account에는 두 개의 보안키가 있으며, 다음과 같은 방법으로 키 값을 반환할 수 있습니다.

#### Azure Service Management(Classic)

ASM에서는 Get-AzureStorageKey라는 cmdlet을 사용합니다.

```PowerShell
$subscriptionName = "your subscription name"

Select-AzureRmSubscription -SubscriptionName $subscriptionName

$storageAccountName = "your storage account name"

(Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary
(Get-AzureStorageKey -StorageAccountName $storageAccountName).Secondary
```

마지막 두 줄은 Primary와 Secondary만 다릅니다. 
Primary는 Primary Access Key를, Secondary는 Secondary Key를 의미합니다.

![](https://jyseongfileshare.blob.core.windows.net/images/storage_account-10.png)

#### Azure Resource Manager(ARM)

ARM에서는 Get-AzureRmStorageAccountKey cmdlet을 사용합니다.

```PowerShell
$resourceGroupName = "your resource group name"
$storageAccountName = "your storage account"

(Get-AzureRmStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName).Value[0]
(Get-AzureRmStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName).Value[1]
```

Get-AzureStorageKey cmdlet과는 달리, Primary/Secondary 대신 Value[0]/Value[1]을 사용합니다.
여기서 Value[0]은 포털의 key1을,  Value[1]은 key2를 의미합니다.

![](https://jyseongfileshare.blob.core.windows.net/images/storage_account-11.png)


## Storage Account key 다시 생성하기

Storage Account key는 다양한 이유(보안 규정, 관리 목적 등)로 인해서, 주기적으로 변경을 권고하고 있습니다.
Web 응용 프로그램에서 storage account를 사용하고 있다면, 다음과 같은 순서에 따라서 Storage account key의 변경 절차를 고려해야 합니다.

0. Web 응용 프로그램의 구성 파일에서는 Primary key를 사용하는 것으로 간주합니다.
1. 사용하는 Storage account의 Secondary key를 새로운 key로 다시 생성합니다.
2. Web 응용 프로그램의 구성 파일의 Key 값을 1단계에서 새로 생성한 Key로 변경합니다.
3. Storage account의 Primary key를 새로운 key로 다시 생성합니다.

Storage account의 key를 다시 생성하는 방법은 다음과 같습니다.

#### Azure Service Management(Classic)

```PowerShell
$subscriptionName = "your subscription name"

Select-AzureRmSubscription -SubscriptionName $subscriptionName

$storageAccountName = "your storage account name"

New-AzureStorageKey -StorageAccountName $storageAccountName -KeyType Primary
New-AzureStorageKey -StorageAccountName $storageAccountName -KeyType Secondary
```

#### Azure Resource Manager(ARM)

```PowerShell
$resourceGroupName = "your resource group name"
$storageAccountName = "your storage account"

New-AzureRmStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName -KeyName key1
New-AzureRmStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName -KeyName key2
```

참고 자료
- [Get-AzureStorageKey](https://msdn.microsoft.com/en-us/library/azure/dn495235.aspx)
- [Get-AzureRmStorageAccountKey](https://msdn.microsoft.com/en-us/library/mt607145.aspx)
- [New-AzureStorageKey](https://msdn.microsoft.com/en-us/library/azure/dn495112.aspx)
- [New-AzureRmStorageAccountKey](https://msdn.microsoft.com/en-us/library/mt607143.aspx)