# Conditional Access Policy Export
Connect-MgGraph -Scopes "Policy.Read.All"
Select-MgProfile -Name "beta"

Write-Host "`nExporting Conditional Access policies..." -ForegroundColor Cyan

$policies = Get-MgIdentityConditionalAccessPolicy | 
    Select-Object Id, DisplayName, State, Conditions, GrantControls

$timestamp = (Get-Date).ToString("yyyyMMdd-HHmmss")
$path = "CA-Policy-Export_$timestamp.json"

$policies | ConvertTo-Json -Depth 10 | Out-File $path -Encoding utf8

Write-Host "`nExport complete:`t$path" -ForegroundColor Green
Disconnect-MgGraph
