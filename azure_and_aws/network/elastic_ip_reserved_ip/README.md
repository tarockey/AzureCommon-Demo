# elastic ip vs. reserved ip

공용 IP 주소를 예약(고정)하는 기능은 Azure와 AWS 모두 제공하고 있습니다.
Azure는 Reserved IP라는 기능으로, AWS는 Elastic IP라는 기능으로 제공이 됩니다.

### 개요

각 기능에 대한 설명은 다음의 문서들을 참고하시기 바랍니다.

- Azure의 [예약된 IP 개요](https://azure.microsoft.com/ko-kr/documentation/articles/virtual-networks-reserved-public-ip/)
- AWS의 [탄력적 IP 주소](http://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html)

서비스의 이름은 다르지만,서로 동일한 기능을 제공하고 있습니다.
IP 주소를 사용자가 지정할 수 없으며, IP 주소를 요청하여 받게되는 IP 주소를 사용하게 되는 방식입니다.

두 서비스 모두 IPv4 형식의 IP에 대해서만 예약(고정)이 가능합니다.

### 차이

Azure와 AWS간의 차이는 과금 방법에서 다릅니다.

Azure의 경우(Azure Resource Manager 방식은), 한 지역에서 5개까지의 "정적" 공용 IP는 무료로 제공이 되는데 반해서, 
AWS의 경우에는 할당 받은 탄력적 IP 주소를 EC2 인스턴스에 연결을 해야만 과금이 이루어지지 않습니다.

Azure의 Reserved IP의 가격은 다음의 문서를 참고하시기 바랍니다.

[IP 주소 가격](https://azure.microsoft.com/ko-kr/pricing/details/ip-addresses/)

AWS의 Elastic IP에 대한 가격은 EC2 인스턴스에서 같이 언급이 되고 있습니다.

[Amazon EC2 요금](https://aws.amazon.com/ko/ec2/pricing/on-demand/)

또한, 사용할 수 있는 기본 capacity의 수가 다릅니다.

- AWS는 지역(region)별로 elastic ip 주소를 5개로 기본 제한하고 있으며, 신청을 통하여 확장이 가능합니다([탄력적 IP 주소 제한](http://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#using-instance-addressing-limit)).
- Azure는 기본적으로 20개로 제한이 되며, 동일하게 지원 신청을 통해서 확장이 가능합니다([Azure 구독 및 서비스 제한, 할당량 및 제약 조건](https://azure.microsoft.com/ko-kr/documentation/articles/azure-subscription-service-limits/)).

#### PowerShell - AWS

Elastic IP를 생성, 반환, 삭제하는 PowerShell은 다음과 같습니다.

```PowerShell

Get-AWSCredentials -ListProfiles

$profileName = "default"
$region = "ap-southeast-2"

Initialize-AWSDefaults -ProfileName $profileName -Region $region

New-EC2Address -Domain standard

Get-EC2Address

$allocationId = "eipalloc-########"

Remove-EC2Address -AllocationId $allocationId -Force

```

#### PowerShell - Azure

Reserved IP를 생성, 반환, 삭제하는 PowerShell은 다음과 같습니다.

```PowerShell

Login-AzureRmAccount

$subscriptionName = "Azure Demo"

Select-AzureRmSubscription -SubscriptionName $subscriptionName

$reservedIpName = "MyReservedIP"
$location = "Central US"

New-AzureReservedIP –ReservedIPName $reservedIpName –Location $location

Get-AzureReservedIP

Remove-AzureReservedIP -ReservedIPName $reservedIpName -Force

```