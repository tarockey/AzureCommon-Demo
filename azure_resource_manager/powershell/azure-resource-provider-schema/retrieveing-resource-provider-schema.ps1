### https://github.com/Azure/azure-resource-manager-schemas

$uri1 = "https://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json"
$uri2 = "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json"

$schemaDefs = ((Invoke-WebRequest -Uri $uri1).Content | ConvertFrom-Json).properties.resources.items.oneOf.allOf.oneOf
$schemaDefs += ((Invoke-WebRequest -Uri $uri2).Content | ConvertFrom-Json).properties.resources.items.oneOf.allOf.oneOf

$schemas = @()

foreach ($schemaDef in $schemaDefs)
{
    if ($schemaDef) 
    {
        $schemas += $schemaDef.'$ref'.Substring(0, $schemaDef.'$ref'.IndexOf('#'))
    }
}

$schemaUris = $schemas | Sort-Object -Unique | Out-GridView -Title "Select schema to download" -OutputMode Multiple 

foreach($schemaUri in $schemaUris)
{
    $fileName = -Join("C:\temp\", $schemaUri.ToString().Substring($schemaUri.LastIndexOf('/')+1))
    (Invoke-WebRequest -Uri $schemaUri).Content | Out-File -FilePath $fileName
}



