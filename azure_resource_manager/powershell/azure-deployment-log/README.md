# Azure 배포 로그 확인하기

Azure 상에서 이루어지는 모든 작업은 Azure의 데이터센터에 로그로 기록이 이루어집니다.

해당 작업은 운영 로그(operation log)로도 확인이 가능하며, 배포 작업 단위(deployment)로도 확인이 가능합니다.

운영 로그를 통한 확인 방법은 [다음](https://github.com/jiyongseong/AzureCommon/tree/master/azure_resource_manager/powershell/azure-operation-log)에서 확인하시기 바랍니다.

배포 작업에 대한 로그는 다음과 같이 확인이 가능합니다.

먼저 Azure로 로그인(Login-AzureRmAccount)을 하고, 사용할 Azure 구독을 선택(Select-AzureRmSubscription)합니다.

```powershell
Login-AzureRmAccount

$subscriptName = "your subscription name"
Select-AzureRmSubscription -SubscriptionName $subscriptName
```

배포 로그는 리소스 그룹별로 확인이 가능합니다. 따라서, 확인할 리소스 그룹을 지정하여 어떤 배포 작업이 있었는지 확인을 합니다.

만약, 리소스 그룹의 이름을 모르는 경우에는 다음의 cmdlet을 이용하여 리소스 그룹의 목록을 확인할 수 있습니다.

```powershell
Get-AzureRmResourceGroup | Select ResourceGroupName, Location
```

![](https://jyseongfileshare.blob.core.windows.net/images/azure-deployment-log-01.png)

다음에는 확인된 리소스 그룹을 지정하여, 작업 목록을 반환합니다.

```powershell
$resourceGroupName = "your resource group name"
Get-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName | SELECT DeploymentName, ResourceGroupName, ProvisioningState, Timestamp, Mode, TemplateLink | Format-Table
```
![](https://jyseongfileshare.blob.core.windows.net/images/azure-deployment-log-02.png)

목록에서 원하는 배포 이름(DeploymentName)을 $deploymentName에 할당합니다. 아래의 예제에서는 "OpenLogic.CentOSbased72-20160721200823"라는 배포 작업을 선택하였습니다.

```powershell
$deploymentName = "OpenLogic.CentOSbased72-20160721200823"
(Get-AzureRmResourceGroupDeploymentOperation -DeploymentName $deploymentName -ResourceGroupName $resourceGroupName).Properties 
```
실행한 결과는 다음과 같이 보여집니다.

![](https://jyseongfileshare.blob.core.windows.net/images/azure-deployment-log-03.png)

만약 성공한 것을 제외한 나머지 로그들을 확인하고 싶다면, 다음과 같이 PowerShell 스크립트를 수정하여 실행하시면 됩니다.

```powershell
$deploymentName = "OpenLogic.CentOSbased72-20160721200823"
(Get-AzureRmResourceGroupDeploymentOperation -DeploymentName $deploymentName -ResourceGroupName $resourceGroupName).Properties | Where-Object provisioningState -NE "Succeeded"
```

해당 내용은 포털에서도 다음과 같이 확인이 가능합니다.

![](https://jyseongfileshare.blob.core.windows.net/images/azure-deployment-log-04.png)

각 배포 작업을 선택하면, 우측에 상세 정보들이 보여지게 됩니다.

![](https://jyseongfileshare.blob.core.windows.net/images/azure-deployment-log-05.png)

좀 더 자세한 내용은 다음의 문서를 참고하세요.

[View deployment operations with Azure PowerShell](https://github.com/Azure/azure-content/blob/master/articles/resource-manager-troubleshoot-deployments-powershell.md)