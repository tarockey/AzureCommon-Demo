# Azure useful codes and best practices
Micorsoft Azure IaaS(Infrastructure as a Services)/PaaS(Platform as a Services) 서비스들을 제외한 이외의 기능들에 대한 유용한 코드들과 best practice들을 공유합니다.

## Resource templates

#### [SQL Server 데이터베이스를 Azure SQL Database로 배포하기(Azure resource template + bacpac)](https://github.com/jiyongseong/AzureCommon/tree/master/azure_resource_manager/template/import_bacpac_to_azuresql)
- Azure Resource template + bacpac을 이용하여, on-premises의 SQL Server 데이터베이스를 Azure SQL Databases로 이전하기.

## [Azure PowerShell](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure)

### [Azure PowerShell - Storage Account](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account)

#### [Storage Account > 생성/수정/삭제](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/storage_account_basic)
* [로그인](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/storage_account_basic#로그인)
* [Storage Account 만들기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/storage_account_basic#storage-account-만들기)
* [Storage Account 설정 변경하기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/storage_account_basic#storage-account-설정-변경하기)
* [Storage Account 삭제하기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/storage_account_basic#storage-account-삭제하기)
* [Storage Account key 가져오기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/storage_account_1#storage-account-key-가져오기)
* [Storage Account key 다시 생성하기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/storage_account_1#storage-account-key-다시-생성하기)

#### [Blob 관리](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/blob)
* [Blob container 만들기 ](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/blob#blob-container-만들기)
* [Tweak - CurrentStorageAccountName](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/blob#tweak)
* [Blob container 목록 가져오기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/blob#blob-container-목록-가져오기)
* [Blob container의 액세스 정책 변경하기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/blob#blob-container의-액세스-정책-변경하기)
* [Blob container 삭제하기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/blob#blob-container-삭제하기)

#### [Blob 이용하기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/blob_uploading_blob)
* [Blob에 파일 올리기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/blob_uploading_blob#blob에-파일-올리기)
* [Tweak - 로컬에 있는 폴더 전체를 blob에 올리기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/blob_uploading_blob#tweak---로컬에-있는-폴더-전체를-blob에-올리기)
* [Blob 파일/목록 가져오기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/blob_get_blob#blob-파일목록-가져오기)
* [Blob 삭제하기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/blob_get_blob#blob-삭제하기)
* [Blob 다운로드 하기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/blob_get_blob#blob-다운로드-하기)

#### [Azure File Storage 이용하기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/file)
* [Azure File Share/Directory 생성하기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/file#azure-file-sharedirectory-생성하기)
* [Azure File Share/Directory에 파일 올리기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/file#azure-file-sharedirectory에-파일-올리기)
* [Tweak - 로컬에 있는 폴더 전체를 Azure file에 올리기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/file#tweak---로컬에-있는-폴더-전체를-azure-file에-올리기)
* [Azure File Share/Directory 삭제하기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/file#azure-file-sharedirectory-삭제하기)

#### [Azure Table Storage 이용하기](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/storage_account/table)

### 기타

#### [Azure Resource Group 간에 Resource 옮기기 (PowerShell)](https://github.com/jiyongseong/AzureCommon/tree/master/azure_resource_manager/powershell/moving-resources-between-azure-resource-groups)
- Azure PowerShell을 이용하여, 특정 Resource Group에 있는 모든 리소스들을 다른 Resource Group으로 이동시키는 방법을 설명하고 있습니다.

#### [Azure 운영 로그 내려 받기 (PowerShell)](https://github.com/jiyongseong/AzureCommon/tree/master/azure_resource_manager/powershell/azure-operation-log) 
- Azure PowerShell을 이용하여 Azure의 운영로그를 csv 파일로 내려 받기

#### [Azure 배포 로그 확인 받기 (PowerShell)](https://github.com/jiyongseong/AzureCommon/tree/master/azure_resource_manager/powershell/azure-deployment-log) 
- Azure PowerShell을 이용하여 Azure의 배포 로그 확인 하기

#### [Azure PowerShell 버전 확인하기 (PowerShell)](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/azure/version) 
- Azure PowerShell의 버전 및 모듈, cmdlet들 확인하기

## 이외의 것들

#### [현재 머신의 모든 성능 카운터 목록 반환 (PowerShell)](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/fun/list_perf_counters)
#### [Public Ip 주소 확인 (PowerShell)](https://github.com/jiyongseong/AzureCommon/tree/master/powershell/fun/what_is_my_ip)

**성지용([jiyongseong](https://github.com/jiyongseong))**
