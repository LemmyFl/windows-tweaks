New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client" -Force | Out-Null
New-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client" -Name RedirectionWarningDialogVersion -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty "HKCU:\SOFTWARE\Microsoft\Terminal Server Client" -Name RdpLaunchConsentAccepted -PropertyType DWord -Value 1 -Force | Out-Null
