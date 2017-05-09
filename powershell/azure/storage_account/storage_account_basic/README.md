# Azure PowerShell - Storage Account > 생성/수정/삭제

Azure Storage account가 무엇인지에 대해서는 아래의 링크들을 참고하시기 바랍니다.

* [Introduction to Microsoft Azure Storage](https://docs.microsoft.com/en-us/azure/storage/storage-introduction)
* [About Azure storage accounts](https://azure.microsoft.com/en-us/documentation/articles/storage-create-storage-account/)

## 로그인 
#### Azure Service Management(Classic)

```PowerShell
Add-AzureAccount
```
#### Azure Resource Manager(ARM)
```PowerShell
Login-AzureRmAccount
```

## Storage Account 만들기 
#### Azure Service Management(Classic)

로그인이 완료되면, 다음에는 사용하려는 Azure의 구독을 선택합니다.

```PowerShell
$subscriptionName = "your subscription name"
Select-AzureSubscription -SubscriptionName $subscriptionName
```

어떤 구독들이 있는지 알수 없다면, 다음의 구문을 이용하여 구독의 목록을 확인할 수 있습니다.

```PowerShell
Get-AzureSubscription | Format-Table
```

다음에는 생성할 위치($location)와 생성할 storage account의 이름($storageAccountName)을 지정합니다.

Azure Storage account의 이름은 알파벳(소문자)과 숫자만 허용을 합니다. 

생성할 위치는 "East Asia"를 지정하였습니다. 

사용 가능한 지역 목록은 Get-AzureLocation cmdlet을 이용하면 확인이 가능합니다.

다음에는 Test-AzureName cmdlet을 이용하여 $storageAccountName 할당한 이름이 사용되고 있는지를 검사합니다.

```PowerShell
$location = "East Asia" 
$storageAccountName = "your storage account name"

$test = Test-AzureName -Storage -Name $storageAccountName
```

결과로 true가 반환되면, 이미 사용중인 이름이라는 의미입니다.
false가 반환되면, New-AzureStorageAccount cmdlet을 이용하여 Storage Account를 생성하게 됩니다.
* -StorageAccountName $storageAccountName : storage account의 이름입니다.
* -Location $location : storage account가 생성될 위치입니다.
* -Type Standard_LRS
    * storage account는 다양한 복제 옵션을 제공하고 있습니다. 여기서는 복제 옵션을 지정하게 됩니다.
    * storage account에서 제공하는 복제 옵션들에 대해서는 [Replication for Durability and High Availability](https://azure.microsoft.com/en-us/documentation/articles/storage-introduction/#replication-for-durability-and-high-availability)를 참고하시기 바랍니다.

```PowerShell
if ($test -eq $true)
{
    Write-Host -Object "'$storageAccountName' is already exists." -ForegroundColor Yellow -BackgroundColor DarkRed
}
else
{
    New-AzureStorageAccount -StorageAccountName $storageAccountName -Location $location -Type Standard_LRS 
}
```

Azure Service Management로 Storage Account를 생성하는 전체 코드는 다음과 같습니다.

```PowerShell
$subscriptionName = "your subscription name"
Select-AzureSubscription -SubscriptionName $subscriptionName

$location = "East Asia" 
$storageAccountName = "your storage account name"

$test = Test-AzureName -Storage -Name $storageAccountName
if ($test -eq $true)
{
    Write-Host -Object "'$storageAccountName' is already exists." -ForegroundColor Yellow -BackgroundColor DarkRed
}
else
{
    New-AzureStorageAccount -StorageAccountName $storageAccountName -Location $location -Type Standard_LRS -Label "Test Storage account - East Asia"
}
```

참고 자료 : [New-AzureStorageAccount](https://msdn.microsoft.com/en-us/library/azure/dn495115.aspx)


#### Azure Resource Manager(ARM)

로그인이 완료되면, 다음에는 사용하려는 Azure의 구독을 선택합니다.

```PowerShell
$subscriptionName = "your subscription name"
Select-AzureRmSubscription -SubscriptionName $subscriptionName
```

어떤 구독들이 있는지 알수 없다면, 다음의 구문을 이용하여 구독의 목록을 확인할 수 있습니다.

```PowerShell
Get-AzureRMSubscription | Format-Table
```

다음에는 리소스 그룹($resourceGroupName), 생성할 위치($location)와 생성할 storage account의 이름($storageAccountName)을 지정합니다.

Azure Storage account의 이름은 알파벳(소문자)과 숫자만 허용을 합니다. 

생성할 위치는 "East Asia"를 지정하였습니다. 

사용 가능한 지역 목록은 Get-AzureRMLocation cmdlet을 이용하면 확인이 가능합니다.

다음에는 New-AzureRmResourceGroup cmdlet을 이용하여 리소스 그룹을 생성합니다. 이미 같은 이름의 리소스 그룹이 있더라도 오류는 발생하지 않고, 정보를 업데이트하게 됩니다.

마지막으로, Test-AzureName cmdlet을 이용하여 $storageAccountName 할당한 이름이 사용되고 있는지를 검사합니다.

```PowerShell
$resourceGroupName = "your resource group"
$location = "East Asia" #Get-AzureRmLocation
$storageAccountName = "your storage account name"

New-AzureRmResourceGroup -Name $resourceGroupName -Location $location -Force

$test = Test-AzureName -Storage -Name $storageAccountName
```

결과로 true가 반환되면, 이미 사용중인 이름이라는 의미입니다.
false가 반환되면, New-AzureRmStorageAccount cmdlet을 이용하여 Storage Account를 생성하게 됩니다.
* -ResourceGroupName $resourceGroupName : Storage Account를 생성할 리소스 그룹 이름
* -StorageAccountName $storageAccountName : storage account의 이름입니다.
* -Location $location : storage account가 생성될 위치입니다.
* -SkuName Standard_LRS 
    * storage account는 다양한 복제 옵션을 제공하고 있습니다. 여기서는 복제 옵션을 지정하게 됩니다.
    * storage account에서 제공하는 복제 옵션들에 대해서는 [Replication for Durability and High Availability](https://azure.microsoft.com/en-us/documentation/articles/storage-introduction/#replication-for-durability-and-high-availability)를 참고하시기 바랍니다.

```PowerShell
if ($test -eq $true)
{
    Write-Host -Object "'$storageAccountName' is already exists." -ForegroundColor Yellow -BackgroundColor DarkRed
}
else
{
    New-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -Location $location -SkuName Standard_LRS -Kind Storage 
}
```

위에서는 Standard Storage를 생성하였습니다만, [Premium Storage](https://azure.microsoft.com/en-us/documentation/articles/storage-premium-storage/)는 New-AzureRmStorageAccount 구문을 다음과 같이 변경하면 됩니다.

```PowerShell
New-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -Location $location -SkuName Premium_LRS
```

[Cool storage](https://azure.microsoft.com/en-us/documentation/articles/storage-blob-storage-tiers/)는 다음과 같이 변경하면 됩니다.

```PowerShell
New-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -Location $location -Kind BlobStorage -AccessTier Cool -SkuName Standard_LRS
```

Azure Resource Management로 Storage Account를 생성하는 전체 코드는 다음과 같습니다.

```PowerShell
Login-AzureRmAccount

$subscriptionName = "your subscription name"
Select-AzureRmSubscription -SubscriptionName $subscriptionName

$resourceGroupName = "your resource group"
$location = "East Asia" #Get-AzureRmLocation
$storageAccountName = "your storage account name"

New-AzureRmResourceGroup -Name $resourceGroupName -Location $location -Force

$test = Test-AzureName -Storage -Name $storageAccountName
if ($test -eq $true)
{
    Write-Host -Object "'$storageAccountName' is already exists." -ForegroundColor Yellow -BackgroundColor DarkRed
}
else
{
    New-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -Location $location -SkuName Standard_LRS -Kind Storage 
    #New-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -Location $location -SkuName Premium_LRS
    #New-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -Location $location -Kind BlobStorage -AccessTier Cool -SkuName Standard_LRS
}
```

참고 자료 : [New-AzureRmStorageAccount](https://msdn.microsoft.com/en-us/library/mt607148.aspx)

## Storage Account 설정 변경하기 
#### Azure Service Management(Classic)

다음과 같이, 앞서 생성한 Storage Account의 속성을 변경하는 작업도 가능합니다. 

```PowerShell
Set-AzureStorageAccount -StorageAccountName $storageAccountName -Type Standard_GRS -Label "LRS"

Get-AzureStorageAccount -StorageAccountName $storageAccountName
```

Set-AzureStorageAccount cmdlet을 이용하는 스크립트는 Storage Account의 복제 옵션을 Standard_GRS로 변경하게 됩니다.

Get-AzureStorageAccount cmdlet은 해당 Storage Account의 상세 정보를 반환합니다.

![](https://jyseongfileshare.blob.core.windows.net/images/storage_account-01.png)

참고 자료 :
  * [Set-AzureStorageAccount](https://msdn.microsoft.com/en-us/library/azure/dn495306.aspx)
  * [Get-AzureStorageAccount](https://msdn.microsoft.com/en-us/library/azure/dn495134.aspx)

#### Azure Resource Manager(ARM)

Class 방식과 마찬가지로, ARM도 동일하게 Storage Account의 속성을 변경하는 작업이 가능합니다.

```PowerShell
Set-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -SkuName Standard_GRS

(Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName).Sku.Name
```

Set-AzureRMStorageAccount cmdlet을 이용하는 스크립트는 Storage Account의 복제 옵션을 Standard_GRS로 변경하게 됩니다.

```PowerShell
Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
```

상기의 구문을 실행한 결과는 다음과 같습니다.

![](https://jyseongfileshare.blob.core.windows.net/images/storage_account-02.png)

Get-AzureRmStorageAccount는 Classic 방식과는 조금 다른 항목의 결과를 반환합니다.

Classic에서는 Account Type으로 Storage Account의 복제 옵션을 확인할 수 있었지만, ARM에서는 Sku 항목을 확인해야 합니다.

![](https://jyseongfileshare.blob.core.windows.net/images/storage_account-03.png)

참고 자료 :
  *   [Set-AzureRmStorageAccount](https://msdn.microsoft.com/en-us/library/mt607146.aspx)
  *   [Get-AzureRmStorageAccount](https://msdn.microsoft.com/en-us/library/mt607149.aspx)

## Storage Account 삭제하기

___주의 : 실제 운영하는 데이터가 적제되어 있는 Storage Account에 대해서, 아래의 스크립트를 실행해서는 안됩니다. 모든 데이터가 삭제되고, 복구되지 않을 수 있습니다___ 

#### Azure Service Management(Classic)

Classic Storage Account는 다음의 구문을 이용하여 삭제가 가능합니다.

```PowerShell
Remove-AzureStorageAccount -StorageAccountName $storageAccountName
```

참고 자료 : [Remove-AzureStorageAccount](https://msdn.microsoft.com/en-us/library/azure/dn495212.aspx)

#### Azure Resource Manager(ARM)

ARM 환경의 Storage Account는 다음과 같은 방식으로 삭제가 가능합니다.

```PowerShell
Remove-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -Force
```

참고 자료 : [Remove-AzureRmStorageAccount](https://msdn.microsoft.com/en-us/library/mt607150.aspx)
