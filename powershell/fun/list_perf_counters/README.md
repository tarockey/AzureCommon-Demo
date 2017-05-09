# 현재 머신의 모든 성능 카운터 목록 반환 (PowerShell)

아래의 PowerShell 스크립트를 실행하는 머신의 모든 성능 카운터 목록을 반환

```PowerShell
$counterSets = Get-Counter -ListSet * 

 foreach($counterSet in $counterSets)
 {
    Write-Host $counterSet.CounterSetName -BackgroundColor Yellow -ForegroundColor Red
    foreach($counter in $counterSet.Counter)
    {
        Write-Host "     " $counter
    } 
 }
```

결과는 다음과 같이 보여지게 됩니다.

![](https://jyseongfileshare.blob.core.windows.net/images/list_perf_counters.png)
