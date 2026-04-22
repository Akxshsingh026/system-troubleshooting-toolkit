# ============================================
# System Troubleshooting Toolkit
# ============================================

Write-Host "=== System Troubleshooting Toolkit ===" -ForegroundColor Green

# --------------------------------------------
# Check if script is running as Administrator
# Required for system-level commands like SFC, CHKDSK, network reset
# --------------------------------------------
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($currentUser)

if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run as Administrator!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

# --------------------------------------------
# Detect if PC is part of a domain
# Domain environments (Active Directory) may restrict some commands
# --------------------------------------------
$computerSystem = Get-WmiObject Win32_ComputerSystem
if ($computerSystem.PartOfDomain) {
    Write-Host "Domain environment detected - some operations may be restricted by Group Policy." -ForegroundColor Yellow
}

# --------------------------------------------
# [1/5] Clean temporary files
# Some files may not delete because they are in use by the system
# --------------------------------------------
Write-Host "`n[1/5] Cleaning Temp Files..."
Try {
    Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction Stop
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction Stop
    Write-Host "Temp files cleaned."
} Catch {
    Write-Host "Some temp files could not be deleted (in use or protected)."
}

# --------------------------------------------
# [2/5] Flush DNS cache
# Clears cached domain/IP mappings
# Works in both local and domain environments
# --------------------------------------------
Write-Host "`n[2/5] Flushing DNS..." -ForegroundColor Yellow
ipconfig /flushdns

# --------------------------------------------
# [3/5] Reset network (release/renew IP)
# NOTE:
# - Works only if adapter is active (Status = Up)
# - Will fail if:
#   * No network connection
#   * Static IP is configured
#   * Adapter is disabled
#   * Controlled by domain policy
# --------------------------------------------
Write-Host "`n[3/5] Resetting Network..."

$adapters = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}

if ($adapters) {
    foreach ($adapter in $adapters) {
        Write-Host "Resetting adapter: $($adapter.InterfaceAlias)"
        ipconfig /release "$($adapter.InterfaceAlias)"
        ipconfig /renew "$($adapter.InterfaceAlias)"
    }
} else {
    Write-Host "No active network adapters found. Skipping network reset." -ForegroundColor Yellow
}

# --------------------------------------------
# [4/5] Disk check
# Cannot run immediately on system drive (C:) because it's in use
# Will schedule scan at next reboot
# --------------------------------------------
Write-Host "`n[4/5] Checking Disk..."
Write-Host "Disk check will run after restart..."
echo Y | chkdsk C: /f /r

# --------------------------------------------
# [5/5] System File Checker
# Scans and repairs corrupted Windows system files
# Requires Administrator privileges
# --------------------------------------------
Write-Host "`n[5/5] Running SFC Scan..."
sfc /scannow

# --------------------------------------------
# Completed
# --------------------------------------------
Write-Host "`n=== Completed Successfully ===" -ForegroundColor Green
Read-Host "Press Enter to exit"