# Public Ip 주소 확인 (PowerShell)

아래의 PowerShell 스크립트가 실행되는 호스트의 public ip 주소를 반환하게 됩니다.

```PowerShell
(Invoke-WebRequest ifconfig.me/ip).Content
```

명령 프로프트의 ipconfig와 동일한 결과를 반환하는 PowerShell cmdlet은 다음과 같습니다.

```PowerShell
Get-NetIPAddress
```

다음의 문서를 참고하였습니다.

[PowerTip: Use PowerShell to Get IP Addresses](https://blogs.technet.microsoft.com/heyscriptingguy/2014/04/10/powertip-use-powershell-to-get-ip-addresses/)