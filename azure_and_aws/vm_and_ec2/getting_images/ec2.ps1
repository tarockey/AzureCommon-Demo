Get-EC2ImageByName -Name "Windows_Server-2012-R2_RTM-Korean-64Bit-Base-2016.07.13"

Get-EC2Image | Out-GridView

Get-EC2Image -Filter @{ Name="owner-alias"; Values="amazon"} | Out-GridView

Get-EC2Image -Filter @{ Name="platform"; Values="windows"} | Out-GridView

Get-EC2Image -ImageId "ami-000bc16e"