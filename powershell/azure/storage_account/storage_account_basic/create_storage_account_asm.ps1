Add-AzureAccount

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
