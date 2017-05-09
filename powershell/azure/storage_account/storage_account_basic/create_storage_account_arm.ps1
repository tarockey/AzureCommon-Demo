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


