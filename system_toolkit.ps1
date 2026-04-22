Write-Host "=== System Troubleshooting Toolkit ===" -ForegroundColor Green

# Check Admin Rights
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($currentUser)

if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run as Administrator!"
    Read-Host "Press Enter to exit"
    exit
}

# Temp Cleanup
Write-Host "`n[1/5] Cleaning Temp Files..."
Try {
    Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction Stop
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction Stop
    Write-Host "Temp files cleaned."
} Catch {
    Write-Host "Some temp files could not be deleted."
}

# Flush DNS
Write-Host "`n[2/5] Flushing DNS..." -ForegroundColor Yellow
ipconfig /flushdns

# Network Reset
Write-Host "`n[3/5] Resetting Network..."
# 
#ipconfig /release
#ipconfig /renew

# Disk Check
Write-Host "`n[4/5] Checking Disk..."
Write-Host "Scheduling disk check on next reboot..."
echo Y | chkdsk C: /f /r

# System File Checker
Write-Host "`n[5/5] Running SFC Scan..."
sfc /scannow

Write-Host "`n=== Completed Successfully ==="
Read-Host "Press Enter to exit"