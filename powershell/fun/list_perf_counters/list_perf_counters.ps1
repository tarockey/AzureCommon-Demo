$counterSets = Get-Counter -ListSet * 

 foreach($counterSet in $counterSets)
 {
    Write-Host $counterSet.CounterSetName -BackgroundColor Yellow -ForegroundColor Red
    foreach($counter in $counterSet.Counter)
    {
        Write-Host "     " $counter
    } 
 }