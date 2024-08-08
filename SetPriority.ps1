$keyName = Read-Host "Enter the name for the new registry key"

$baseRegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options"
$newKeyPath = "$baseRegistryPath\$keyName"
$perfOptionsKeyPath = "$newKeyPath\PerfOptions"

if (-not (Test-Path $newKeyPath)) {
    New-Item -Path $newKeyPath -Force
    Write-Output "Created registry key: $newKeyPath"
} else {
    Write-Output "Registry key already exists: $newKeyPath"
}

if (-not (Test-Path $perfOptionsKeyPath)) {
    New-Item -Path $perfOptionsKeyPath -Force
    Write-Output "Created registry subkey: $perfOptionsKeyPath"
} else {
    Write-Output "Registry subkey already exists: $perfOptionsKeyPath"
}

$cpuPriorityClassValue = 3
Set-ItemProperty -Path $perfOptionsKeyPath -Name "CpuPriorityClass" -Value $cpuPriorityClassValue -Type DWord
Write-Output "Set CpuPriorityClass DWORD value to $cpuPriorityClassValue"

Get-ItemProperty -Path $perfOptionsKeyPath
