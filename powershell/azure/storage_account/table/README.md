# Azure PowerShell - Table 이용하기

Azure Table Storage에 대해서는 다음의 자료를 참고하시기 바랍니다.

* [Get started with Azure Table storage](https://docs.microsoft.com/en-us/azure/storage/storage-dotnet-how-to-use-tables)

Azure Table Storage는 다음과 같은 구조로 되어 있습니다.

![](https://docs.microsoft.com/en-us/azure/includes/media/storage-table-concepts-include/table1.png)

Storage Account와 Table에 대한 관리 기능의 cmdlet들은 Azure PowerShell에서 제공되고 있으나, Entity를 관리하는 기능은  Microsoft.WindowsAzure.Storage.Table namespace의 클래스들을 이용하여야 합니다.

Table을 관리하는 cmdlet은 크게 다음의 3가지 cmdlet들이 제공되고 있으며,

- [New-AzureStorageTable](https://msdn.microsoft.com/en-us/library/dn806417.aspx)
- [Get-AzureStorageTable](https://msdn.microsoft.com/en-us/library/mt603686.aspx)
- [Remove-AzureStorageTable](https://msdn.microsoft.com/en-us/library/mt619461.aspx)

사용 방법 및 예제 코드는 다음의 Azure 문서에서 잘 다루고 있습니다.

[How to manage Azure tables and table entities](https://docs.microsoft.com/en-us/azure/storage/storage-powershell-guide-full#how-to-manage-azure-tables-and-table-entities)
