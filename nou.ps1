$NewOutlook = Get-AppxPackage | Where-Object { $_.Name -like "*OutlookNew*" }

if ($NewOutlook) {
    Write-Host "New Outlook detected. Uninstalling..."
    
    # Uninstall via Winget (Recommended)
    try {
        winget uninstall "Microsoft Outlook" --silent --accept-source-agreements
        Write-Host "New Outlook uninstalled successfully."
    }
    catch {
        Write-Host "Winget not available. Trying PowerShell method..."
        
        # Uninstall via PowerShell
        try {
            Remove-AppxPackage -Package $NewOutlook.PackageFullName -ErrorAction Stop
            Write-Host "New Outlook uninstalled successfully."
        }
        catch {
            Write-Host "Failed to uninstall New Outlook. Please remove it manually."
        }
    }
}
else {
    Write-Host "New Outlook is NOT installed."
}
