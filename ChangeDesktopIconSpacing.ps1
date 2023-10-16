# ChangeDesktopIconSpacing.ps1

# Check and request elevation if not already an administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "Script needs to be run as Administrator. Attempting to relaunch."
    Start-Process -Verb runas -FilePath powershell.exe -ArgumentList "-ExecutionPolicy Bypass -NoProfile -File `"$($MyInvocation.MyCommand.Definition)`""
    exit
}

# Navigate to the registry path
$regPath = "HKCU:\Control Panel\Desktop\WindowMetrics"

# Check if the registry path exists
if (Test-Path $regPath) {
    # Set the values
    Set-ItemProperty -Path $regPath -Name "IconSpacing" -Value "-1125"
    Set-ItemProperty -Path $regPath -Name "IconVerticalSpacing" -Value "-1125"
    Write-Output "Icon Spacing and Icon Vertical Spacing have been changed successfully."

    # Ask the user if they want to restart the computer
    $userChoice = Read-Host "Do you want to restart your computer now? (y/n)"
    if ($userChoice -eq 'y') {
        Restart-Computer
    }
} else {
    Write-Warning "Registry path $regPath not found."
}

# End of script
