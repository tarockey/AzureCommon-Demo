Login-AzureRmAccount

$subscriptionName = "yout subscription name"
$location = "eastasia"

Get-AzureRmVMImagePublisher -Location $location | Where-Object {$_.PublisherName -like "MicrosoftSQL*"}

$publisherName = "MicrosoftSQLServer"
Get-AzureRmVMImageOffer -Location $location -PublisherName $publisherName

$offerName = "SQL2016-WS2016"
Get-AzureRmVMImageSku -Location $location -PublisherName $publisherName -Offer $offerName

$skuName = "Enterprise"
Get-AzureRmVMImage -Location $location -PublisherName $publisherName -Offer $offerName -Skus $skuName