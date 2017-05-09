# Azure PowerShell 버전 확인하기 (PowerShell)

현재 로컬 컴퓨터에 설치된 Azure PowerShell 버전은 다음의 스크립트로 확인이 가능합니다.

```powershell
Import-Module -Name Azure*
Get-Module -Name Azure* | Select Name, Version
```
실행한 결과는 다음과 같이 보여지게 됩니다.

![](https://jyseongfileshare.blob.core.windows.net/images/version-01.png)

현재까지 배포된 최신의 Azure PowerShell 버전은 다음의 링크에서 확인이 가능합니다(안타깝게도 PowerShell을 이용하여 확인할 수 있는 cmdlet은 제공되지 않고 있습니다).

[Azure PowerShell 최신 버전](https://github.com/Azure/azure-powershell/releases)

Azure PowerShell에서 제공되는 모듈의 목록과 각 모듈의 버전은 다음의 스크립트로 확인이 가능합니다.

```powershell
Get-Command -Module Azure* -CommandType Cmdlet| Sort-Object ModuleName| Select ModuleName, Version | Get-Unique -AsString
```

![](https://jyseongfileshare.blob.core.windows.net/images/version-02.png)


Azure PowerShell에서 제공되는 모든 cmdlet들은 다음의 스크립트로 확인이 가능합니다.

```powershell
Get-Command -Module Azure* -CommandType Cmdlet | Select ModuleName, Name, Verb, Noun | Sort-Object ModuleName, Noun, Verb
```

![](https://jyseongfileshare.blob.core.windows.net/images/version-03.png)
