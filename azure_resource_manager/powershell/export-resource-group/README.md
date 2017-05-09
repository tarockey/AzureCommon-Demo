# Resource Group 템플릿 export 하기

다음의 PowerShell 스크립트는 지정된 Resource Group의 리소스들을 JSON 형식의 템플릿 파일로 export합니다.

```PowerShell
Login-AzureRmAccount

$subscriptionName = "your subscription name"

Select-AzureRMSubscription -SubscriptionName $subscriptionName

Get-AzureRmResourceGroup | Select ResourceGroupName, Location

$resourceGroupName = "export하려는 resource group 이름"

Export-AzureRMResourceGroup -ResourceGroupName $resourceGroupName -Path "C:\temp\$resourceGroupName.json"
```