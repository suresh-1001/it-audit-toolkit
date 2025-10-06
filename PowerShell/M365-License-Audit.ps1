# M365 License Audit Script
# Lists assigned and unassigned Microsoft 365 licenses
Connect-MgGraph -Scopes "User.Read.All","Organization.Read.All","Directory.Read.All"
Select-MgProfile -Name "beta"

Write-Host "`nRetrieving Microsoft 365 License Summary..." -ForegroundColor Cyan

$licenses = Get-MgSubscribedSku | Select-Object -Property SkuPartNumber, ConsumedUnits, @{Name="ActiveUnits";Expression={$_.PrepaidUnits.Enabled}}

$licenses | ForEach-Object {
    [PSCustomObject]@{
        License         = $_.SkuPartNumber
        Assigned_Units  = $_.ConsumedUnits
        Active_Units    = $_.ActiveUnits
        Unused_Units    = $_.ActiveUnits - $_.ConsumedUnits
    }
} | Format-Table
Disconnect-MgGraph
