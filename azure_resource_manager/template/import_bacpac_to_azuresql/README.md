# SQL Server 데이터베이스를 Azure SQL Database로 배포하기(Azure resource template + bacpac)

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fjiyongseong%2FAzureCommon%2Fmaster%2Fazure_resource_manager%2Ftemplate%2Fimport_bacpac_to_azuresql%2FTemplates%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

On-Premises에서 사용 중인 SQL Server의 사용자 데이터베이스를 Azure SQL Database로 배포하는 경우가 종종 있습니다.

데이터베이스 이전은 다양한 방법으로 가능합니다만, 이번에는 Azure의 Resource template과 bacpac 파일을 이용하여 Azure SQL Databases에 데이터베이스를 이전하는 방법을 템플릿으로 공유합니다.

전체적인 단계는 매우 간단하며, 다음과 같습니다.

1. On-premises에 있는 SQL Server의 데이터베이스를 bacpac 파일로 내보내기
2. bacpac 파일을 Azure Storage Account의 Blob으로 올리기
3. Azure Resource template를 이용하여 데이터베이스 배포하기

상기의 1,2번 단계는 한 번의 작업으로도 충분히 수행이 가능합니다. 자세한 단계는 [How to Export an On-Premises SQL Server Database to Windows Azure Storage](https://blogs.msdn.microsoft.com/brunoterkaly/2013/09/26/how-to-export-an-on-premises-sql-server-database-to-windows-azure-storage/)를 참고하시기 바랍니다.

1, 2번 단계가 완료되었다면, 이제는 Azure resource template를 작성합니다.

**해당 리소스 템플릿을 Visual Studio를 이용하여 배포하는 방법에 대해서는 [여기](https://github.com/jiyongseong/AzureIaaSHol/tree/master/2-iis-vms-sql-vm-template)를 참고하시기 바랍니다.**


먼저 템플릿에서 사용할 매개 변수 파일은 다음과 같습니다.

### azuredeploy.parameters.json
```JSON
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
  "parameters": {
    "azuresqldbserverAdminLogin": {
      "value": "sql server admin login name"
    },
    "azuresqldbserverAdminLoginPassword": {
      "value": "sql server admin login"
    },
    "SQLDatabaseName": {
      "value": "AdventureWorks"
    },
    "azuresqldbserverName": {
      "value": "your azure sql database server name"
    }
  }
}
```

변수 파일은 다음과 같은 정보들을 수정해주어야 합니다.

* azuresqldbserverAdminLogin : Azure SQL Database 서버의 admin 로그인 계정
* azuresqldbserverAdminLoginPassword : 상기 계정의 비밀번호
* SQLDatabaseName : 생성하려는 데이터베이스 이름

다음은 Azure에 생성할 리소스들에 대하여 정의한 파일입니다.

### azuredeploy.json

```JSON
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "azuresqldbserverAdminLogin": {
      "type": "string",
      "minLength": 1
    },
    "azuresqldbserverAdminLoginPassword": {
      "type": "securestring"
    },
    "SQLDatabaseName": {
      "type": "string",
      "minLength": 1
    },
    "azuresqldbserverName": {
      "type": "string",
      "minLength": 1
    },
    "SQLDatabaseCollation": {
      "type": "string",
      "minLength": 1,
      "defaultValue": "SQL_Latin1_General_CP1_CI_AS"
    },
    "SQLDatabaseEdition": {
      "type": "string",
      "defaultValue": "Basic",
      "allowedValues": [
        "Basic",
        "Standard",
        "Premium"
      ]
    },
    "SQLDatabaseRequestedServiceObjectiveName": {
      "type": "string",
      "defaultValue": "Basic",
      "allowedValues": [
        "Basic",
        "S0",
        "S1",
        "S2",
        "P1",
        "P2",
        "P4",
        "P6",
        "P11",
        "P15"
      ],
      "metadata": {
        "description": "Describes the performance level for Edition"
      }
    }
  },
  "variables": {
    "AdventureWorksStorageKeyType": "Secondary",
    "AdventureWorksStorageKey": "your storage account key",
    "AdventureWorksStorageUri": "https://<<your storage account>>.blob.core.windows.net/bacpackincloud/AdventureWorks.bacpac"
  },
  "resources": [
    {
      "name": "[parameters('azuresqldbserverName')]",
      "type": "Microsoft.Sql/servers",
      "location": "[resourceGroup().location]",
      "apiVersion": "2014-04-01-preview",
      "dependsOn": [ ],
      "tags": {
        "displayName": "Azure SQL Database Server"
      },
      "properties": {
        "administratorLogin": "[parameters('azuresqldbserverAdminLogin')]",
        "administratorLoginPassword": "[parameters('azuresqldbserverAdminLoginPassword')]",
        "version": "12.0"
      },
      "resources": [
        {
          "name": "AllowAllWindowsAzureIps",
          "type": "firewallrules",
          "location": "[resourceGroup().location]",
          "apiVersion": "2014-04-01-preview",
          "dependsOn": [
            "[concat('Microsoft.Sql/servers/', parameters('azuresqldbserverName'))]"
          ],
          "properties": {
            "startIpAddress": "0.0.0.0",
            "endIpAddress": "0.0.0.0"
          }
        },
        {
          "name": "[parameters('SQLDatabaseName')]",
          "type": "databases",
          "location": "[resourceGroup().location]",
          "apiVersion": "2014-04-01-preview",
          "dependsOn": [
            "[parameters('azuresqldbserverName')]"
          ],
          "tags": {
            "displayName": "SQLDatabase"
          },
          "properties": {
            "collation": "[parameters('SQLDatabaseCollation')]",
            "edition": "[parameters('SQLDatabaseEdition')]",
            "maxSizeBytes": "1073741824",
            "requestedServiceObjectiveName": "[parameters('SQLDatabaseRequestedServiceObjectiveName')]"
          },
          "resources": [
            {
              "name": "Import",
              "type": "extensions",
              "apiVersion": "2014-04-01-preview",
              "dependsOn": [
                "[parameters('SQLDatabaseName')]"
              ],
              "tags": {
                "displayName": "AdventureWorks"
              },
              "properties": {
                "storageKeyType": "[variables('AdventureWorksStorageKeyType')]",
                "storageKey": "[variables('AdventureWorksStorageKey')]",
                "storageUri": "[variables('AdventureWorksStorageUri')]",
                "administratorLogin": "[parameters('azuresqldbserverAdminLogin')]",
                "administratorLoginPassword": "[parameters('azuresqldbserverAdminLoginPassword')]",
                "operationMode": "Import"
              }
            }
          ]
        }
      ]
    }
  ],
  "outputs": {
  }
}
```

먼저, 생성할 데이터베이스의 tier를 정해주어야 합니다. 위의 JSON 파일에서 다음의 내용을 변경해주시기 바랍니다.

기본 값은 Basic tier를 사용하도록 설정이 되었습니다.

```JSON
    "SQLDatabaseEdition": {
      "type": "string",
      "defaultValue": "Basic",
      "allowedValues": [
        "Basic",
        "Standard",
        "Premium"
      ]
    },
    "SQLDatabaseRequestedServiceObjectiveName": {
      "type": "string",
      "defaultValue": "Basic",
      "allowedValues": [
        "Basic",
        "S0",
        "S1",
        "S2",
        "P1",
        "P2",
        "P4",
        "P6",
        "P11",
        "P15"
      ],
      "metadata": {
        "description": "Describes the performance level for Edition"
      }
    }
  },
```

다음에는 일부 변수들의 값을 설정해줍니다.

```JSON
  "variables": {
    "azuresqldbserverName": "your database server name",
    "AdventureWorksStorageKeyType": "Secondary",
    "AdventureWorksStorageKey": "your storage account key",
    "AdventureWorksStorageUri": "https://<<your storage account>>.blob.core.windows.net/bacpackincloud/AdventureWorks.bacpac"
  },
```

* azuresqldbserverName : Azure SQL Database 서버 이름을 기술합니다.
* AdventureWorksStorageKeyType : 앞서 생성한 bacpac 파일을 업로드한 Azure Storage Account의 키 중에서 첫 번째 키(Primary)를 사용할지, 두 번째 키(Secondary)를 사용할지를 지정합니다. 여기서는 두 번째 키를 사용하도록 선언되어 있습니다.
* AdventureWorksStorageKey : 앞서 선택한 두 번째 키의 값을 입력합니다.
* AdventureWorksStorageUri : bacpac 파일의 전체 URI 경로를 입력합니다.


 **첨언**
 Azure resource template에 대해서 잘 아시고, bacpac을 import하는 부분에만 관심이 있으시다면, 상기의 azuredeploy.json 파일에서 SQL Database 리소스의 다음 부분을 참고하시기 바랍니다.

 ```JSON
 "resources": [
            {
              "name": "Import",
              "type": "extensions",
              "apiVersion": "2014-04-01-preview",
              "dependsOn": [
                "[parameters('SQLDatabaseName')]"
              ],
              "tags": {
                "displayName": "AdventureWorks"
              },
              "properties": {
                "storageKeyType": "[variables('AdventureWorksStorageKeyType')]",
                "storageKey": "[variables('AdventureWorksStorageKey')]",
                "storageUri": "[variables('AdventureWorksStorageUri')]",
                "administratorLogin": "[parameters('azuresqldbserverAdminLogin')]",
                "administratorLoginPassword": "[parameters('azuresqldbserverAdminLoginPassword')]",
                "operationMode": "Import"
              }
            }
          ]
 ```