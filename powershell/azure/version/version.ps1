
Import-Module -Name Azure*
Get-Module -Name Azure* | Select Name, Version

Get-Command -Module Azure* -CommandType Cmdlet| Sort-Object ModuleName| Select ModuleName, Version | Get-Unique -AsString

Get-Command -Module Azure* -CommandType Cmdlet | Select ModuleName, Name, Verb, Noun | Sort-Object ModuleName, Noun, Verb