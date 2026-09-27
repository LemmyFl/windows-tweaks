if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -Command irm https://raw.githubusercontent.com/LemmyFl/windows-tweaks/refs/heads/main/rdp-unsigned-warning-fix.ps1 | iex"
    exit
}
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client" -Force | Out-Null
New-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client" -Name RedirectionWarningDialogVersion -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty "HKCU:\SOFTWARE\Microsoft\Terminal Server Client" -Name RdpLaunchConsentAccepted -PropertyType DWord -Value 1 -Force | Out-Null
