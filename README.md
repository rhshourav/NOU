# 🚀 New Outlook Uninstaller (NOU)

## 📝 Overview
This script automatically detects and **uninstalls New Outlook** on system startup. If "New Outlook" is installed, it will be removed **silently** without user intervention.

## ⚙️ How It Works
1. The script **checks** if New Outlook (`OutlookNew.exe`) is installed.
2. If found, it **uninstalls** it using `winget` or PowerShell.
3. It runs **automatically on startup** via Task Scheduler or the Startup folder.

---

## 🔧 Installation & Setup

### ✅ **Step 1: Download the Script**
Save the following **PowerShell script** as `uninstall_nou.ps1`.

```powershell
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
```

---

## 🖥️ **Step 2: Set Up the Script to Run on Startup**

### 📌 **Method 1: Task Scheduler (Recommended)**
1. Press **`Win + R`**, type `taskschd.msc`, and hit **Enter**.
2. Click **Create Task** on the right panel.
3. Under **General**, name it **"Remove New Outlook"**.
4. Check **"Run with highest privileges"**.
5. Go to **Triggers > New > At Startup**.
6. Go to **Actions > New > Start a Program**.
   - **Program/Script**: `powershell.exe`
   - **Arguments**:
     ```sh
     -ExecutionPolicy Bypass -File "C:\Path\To\uninstall_nou.ps1"
     ```
7. Click **OK**, then restart your PC to test.

### 📌 **Method 2: Add to Startup Folder (Alternative)**
1. Press **Win + R**, type:
   ```sh
   shell:startup
   ```
   and hit **Enter**.
2. Copy and paste `uninstall_nou.ps1` into this folder.
3. Restart your PC to check if the script runs automatically.

---

## ⚠️ Notes
- **Requires Winget** for automatic uninstallation.
- If Winget is unavailable, the script will attempt a **PowerShell-based removal**.
- Run PowerShell as **Administrator** if needed.
- Update the script if Microsoft changes New Outlook’s package name.

---

## 🤝 Contribute
Want to improve this script? Feel free to submit a **pull request** or suggest changes!

---

## 📜 License
This project is licensed under the **MIT License**.

