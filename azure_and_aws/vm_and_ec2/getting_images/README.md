# ec2 vs. vm 이미지 가져오기

AWS와 Azure에서는 다양한 이미지들을 제공하고 있습니다.

이를 Azure에서는 VM 이미지(VM Image)라고 하며, AWS에서는 AMI(Amazon Machine Image)라고 합니다.

AWS와 Azure는 각각 마켓플레이스(Marketplace)를 통해서 다양한 이미지들을 구매하여 사용할 수 있는 기능을 제공하고 있습니다.

### Marketplace

AWS의 Marketplace는 [https://aws.amazon.com/marketplace](https://aws.amazon.com/marketplace)로 접근이 가능합니다.

![](https://jyseongfileshare.blob.core.windows.net/images/getting_images_01.png)

Azure의 Marketplace는 [https://azure.microsoft.com/en-us/marketplace/](https://azure.microsoft.com/en-us/marketplace/)로 접근이 가능합니다.

![](https://jyseongfileshare.blob.core.windows.net/images/getting_images_02.png)

### PowerShell - AWS 

AMI는 PowerShell을 통해서도 검색이 가능합니다.

AMI는 [Get-EC2Image](http://docs.aws.amazon.com/powershell/latest/userguide/pstools-ec2-get-amis.html#pstools-ec2-get-image)와 [Get-EC2ImageByName](http://docs.aws.amazon.com/powershell/latest/userguide/pstools-ec2-get-amis.html#pstools-ec2-get-ec2imagebyname)이라는 cmdlet으로 검색이 가능합니다.

Get-EC2ImageByName cmdlet보다는 Get-EC2Image cmdlet이 좀 더 다양한 파라미터와 옵션을 제공합니다.

전체 이미지 목록은 다음과 같이 반환이 가능합니다. 

```PowerShell

Get-EC2Image | Out-GridView

```

검색은 다음과 같이 -Filter 파라미터를 이용하면 됩니다.

다음의 스크립트에서 사용된 검색 조건은 AMI의 소유자 별칭이 "amazon"인 AMI를 반환하게 됩니다.

```PowerShell

Get-EC2Image -Filter @{ Name="owner-alias"; Values="amazon"} | Out-GridView

```

Windows용 플랫폼 AMI만 반환할 수도 있습니다.

```PowerShell

Get-EC2Image -Filter @{ Name="platform"; Values="windows"} | Out-GridView

```

또는, 이미지 번호(id)를 알고 있는 경우에는 직접 이미지 번호를 입력하여 반환도 가능합니다.

```PowerShell

Get-EC2Image -ImageId "ami-000bc16e"

```

### PowerShell - Azure

Azure의 VM 이미지도 마찬가지로 PowerShell을 이용한 검색을 지원합니다.

Azure의 경우, AWS에 비해서 좀 더 체계적으로 이미지를 찾을 수 있도록 여러 cmdlet들을 제공하며, 다음과 같은 순서로 이미지를 찾을 수 있습니다.

1. 이미지 게시자 : 찾고자 하는 이미지 게시자의 이름을 찾습니다.
2. 이미지 종류 : 이미지 게시자에 의해서 제공되는 제품 종류
3. 이미지 SKU : 제품의 SKU
4. 이미지

먼저 이미지 게시자는 다음과 같이 확인이 가능합니다.

```PowerShell

$location = "eastasia"
Get-AzureRmVMImagePublisher -Location $location 

```

위의 구문은 동아시아 지역(east asia)에 있는 이미지 게시자의 목록을 반환합니다.

SQL Server에 대한 이미지 게시자를 찾으려면 스크립트를 다음과 같이 작성하면 됩니다.

```PowerShell

Get-AzureRmVMImagePublisher -Location $location | Where-Object {$_.PublisherName -like "MicrosoftSQL*"}

```

스크립트를 실행하면 다음과 같은 결과가 반환됩니다.

![](https://jyseongfileshare.blob.core.windows.net/images/getting_images_03.png)

두 번째는 이미지 종류를 찾게 됩니다.

```PowerShell

$publisherName = "MicrosoftSQLServer"
Get-AzureRmVMImageOffer -Location $location -PublisherName $publisherName

```

이미지 종류는 이미지 게시자와 지역을 명시하면 됩니다.

![](https://jyseongfileshare.blob.core.windows.net/images/getting_images_04.png)

반환된 결과에서 원하는 이미지의 종류를 선택합니다. 여기서는 "SQL2016-WS2016"를 선택합니다.

세 번째는 이미지의 SKU를 확인합니다.

```PowerShell

$offerName = "SQL2016-WS2016"
Get-AzureRmVMImageSku -Location $location -PublisherName $publisherName -Offer $offerName

```

이미지 게시자와 종류를 명시하면, 해당 이미지 종류의 SKU들이 반환됩니다.

![](https://jyseongfileshare.blob.core.windows.net/images/getting_images_05.png)

Enterprise Edition을 선택하여, VM 이미지를 가져올 수 있습니다.

```PowerShell

$skuName = "Enterprise"
Get-AzureRmVMImage -Location $location -PublisherName $publisherName -Offer $offerName -Skus $skuName

```

![](https://jyseongfileshare.blob.core.windows.net/images/getting_images_06.png)

참고 자료

- [Get-AzureRmVMImagePublisher](https://msdn.microsoft.com/en-us/library/mt603484.aspx)
- [Get-AzureRmVMImageOffer](https://msdn.microsoft.com/en-us/library/mt603824.aspx)
- [Get-AzureRmVMImageSku](https://msdn.microsoft.com/en-us/library/mt619458.aspx)
- [Get-AzureRmVMImage](https://msdn.microsoft.com/en-us/library/mt603630.aspx)