if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    try {
        Start-Process powershell -Verb RunAs -ArgumentList "-NoExit","-NoProfile","-Command","irm https://raw.githubusercontent.com/LemmyFl/windows-tweaks/refs/heads/main/rdp-unsigned-warning-fix.ps1 | iex" -ErrorAction Stop
    } catch {
        Write-Host "FAILED: Elevation was cancelled or could not start." -ForegroundColor Red
        Read-Host "Press Enter to close"
    }
    return
}

try {
    New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client" -Force -ErrorAction Stop | Out-Null
    New-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client" -Name RedirectionWarningDialogVersion -PropertyType DWord -Value 1 -Force -ErrorAction Stop | Out-Null
    New-ItemProperty "HKCU:\SOFTWARE\Microsoft\Terminal Server Client" -Name RdpLaunchConsentAccepted -PropertyType DWord -Value 1 -Force -ErrorAction Stop | Out-Null
    Write-Host "SUCCESS: RDP unsigned warning disabled." -ForegroundColor Green
} catch {
    Write-Host "FAILED: $($_.Exception.Message)" -ForegroundColor Red
}
Read-Host "Press Enter to close"
