Login-AzureRmAccount

$subscriptName = "your subscription name"
Select-AzureRmSubscription -SubscriptionName $subscriptName

Get-AzureRmResourceGroup | Select ResourceGroupName, Location

$resourceGroupName = "your resource group name"
Get-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName | SELECT DeploymentName, ResourceGroupName, ProvisioningState, Timestamp, Mode, TemplateLink | Format-Table

$deploymentName = "deployment name"
(Get-AzureRmResourceGroupDeploymentOperation -DeploymentName $deploymentName -ResourceGroupName $resourceGroupName).Properties | Where-Object provisioningState -NE "Succeeded"