#Requires -Version 5.1
<#
.SYNOPSIS
Installs OpenVPN Connect for Windows and optionally imports an .ovpn profile.

.DESCRIPTION
This is a Windows client companion for openvpn-install.sh. The Linux script
creates the VPN server and .ovpn client profile; this script installs OpenVPN
Connect on Windows and can import that profile.
#>
[CmdletBinding()]
param(
    [ValidateSet("Menu", "Install", "Import", "InstallAndImport", "Uninstall")]
    [string]$Action = "Menu",

    [string]$ConfigPath,

    [string]$ProfileName,

    [string]$PackageVersion,

    [switch]$Force
)

$ErrorActionPreference = "Stop"

$ScriptVersion = "1.0.0"
$PackageId = "OpenVPNTechnologies.OpenVPNConnect"

function Assert-Windows {
    if ([System.Environment]::OSVersion.Platform -ne [System.PlatformID]::Win32NT) {
        throw "This installer is for Windows only."
    }
}

function Test-Administrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Assert-Administrator {
    if (-not (Test-Administrator)) {
        throw "Run PowerShell as Administrator and try again."
    }
}

function Get-WingetPath {
    $winget = Get-Command winget.exe -ErrorAction SilentlyContinue
    if (-not $winget) {
        throw "winget was not found. Install or update Microsoft App Installer, then run this script again."
    }

    return $winget.Source
}

function Invoke-NativeCommand {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,

        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    & $FilePath @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Command failed with exit code $LASTEXITCODE`: $FilePath $($Arguments -join ' ')"
    }
}

function Join-OptionalPath {
    param(
        [string]$BasePath,
        [string]$ChildPath
    )

    if ([string]::IsNullOrWhiteSpace($BasePath)) {
        return $null
    }

    return Join-Path $BasePath $ChildPath
}

function Get-OpenVpnConnectExe {
    $candidates = @(
        (Join-OptionalPath $env:ProgramFiles "OpenVPN Connect\OpenVPNConnect.exe"),
        (Join-OptionalPath ${env:ProgramFiles(x86)} "OpenVPN Connect\OpenVPNConnect.exe")
    )

    foreach ($candidate in $candidates) {
        if ($candidate -and (Test-Path $candidate)) {
            return $candidate
        }
    }

    throw "OpenVPN Connect executable was not found. Install OpenVPN Connect first."
}

function Get-SafeProfileName {
    param([string]$SourcePath)

    $name = $ProfileName
    if ([string]::IsNullOrWhiteSpace($name)) {
        $name = [IO.Path]::GetFileNameWithoutExtension($SourcePath)
    }

    $name = $name.Trim() -replace '[^\w ._=-]', '-'
    if ([string]::IsNullOrWhiteSpace($name)) {
        throw "Could not determine a safe profile name. Use -ProfileName."
    }

    return $name
}

function Install-OpenVpnConnect {
    $winget = Get-WingetPath
    $arguments = @(
        "install",
        "--exact",
        "--id", $PackageId,
        "--source", "winget",
        "--accept-package-agreements",
        "--accept-source-agreements"
    )

    if ($PackageVersion) {
        $arguments += @("--version", $PackageVersion)
    }

    Write-Host "Installing OpenVPN Connect with winget..."
    Invoke-NativeCommand -FilePath $winget -Arguments $arguments

    $exe = Get-OpenVpnConnectExe
    Write-Host "OpenVPN Connect installed: $exe"
}

function Import-OpenVpnProfile {
    if ([string]::IsNullOrWhiteSpace($ConfigPath)) {
        throw "Provide -ConfigPath with an OpenVPN .ovpn file."
    }

    $resolvedPath = (Resolve-Path $ConfigPath).Path
    if ([IO.Path]::GetExtension($resolvedPath) -ne ".ovpn") {
        throw "OpenVPN client profile must be an .ovpn file."
    }

    $exe = Get-OpenVpnConnectExe
    $safeName = Get-SafeProfileName -SourcePath $resolvedPath

    if ($Force) {
        & $exe "--remove-profile=$safeName" 2>$null
    }

    Write-Host "Importing OpenVPN profile: $safeName"
    Invoke-NativeCommand -FilePath $exe -Arguments @(
        "--accept-gdpr",
        "--skip-startup-dialogs",
        "--import-profile=$resolvedPath",
        "--name=$safeName"
    )

    Start-Process -FilePath $exe -ArgumentList @("--minimize")
    Write-Host "Imported profile '$safeName'. Open OpenVPN Connect and connect when ready."
}

function Uninstall-OpenVpnConnect {
    $winget = Get-WingetPath
    Write-Host "Uninstalling OpenVPN Connect with winget..."
    Invoke-NativeCommand -FilePath $winget -Arguments @(
        "uninstall",
        "--exact",
        "--id", $PackageId,
        "--source", "winget",
        "--accept-source-agreements"
    )
}

function Show-Menu {
    while ($true) {
        Write-Host ""
        Write-Host "==============================="
        Write-Host " OpenVPN Connect Windows Installer"
        Write-Host "==============================="
        Write-Host "Version: $ScriptVersion"
        Write-Host "1) Install or upgrade OpenVPN Connect"
        Write-Host "2) Import OpenVPN .ovpn"
        Write-Host "3) Install and import .ovpn"
        Write-Host "4) Uninstall OpenVPN Connect"
        Write-Host "5) Exit"
        Write-Host ""

        $choice = Read-Host "Select an option [1-5]"
        switch ($choice) {
            "1" { Install-OpenVpnConnect }
            "2" {
                if (-not $ConfigPath) { $script:ConfigPath = Read-Host "Path to .ovpn file" }
                Import-OpenVpnProfile
            }
            "3" {
                if (-not $ConfigPath) { $script:ConfigPath = Read-Host "Path to .ovpn file" }
                Install-OpenVpnConnect
                Import-OpenVpnProfile
            }
            "4" { Uninstall-OpenVpnConnect }
            "5" { return }
            default { Write-Warning "Invalid choice." }
        }
    }
}

Assert-Windows
Assert-Administrator

switch ($Action) {
    "Install" { Install-OpenVpnConnect }
    "Import" { Import-OpenVpnProfile }
    "InstallAndImport" {
        Install-OpenVpnConnect
        Import-OpenVpnProfile
    }
    "Uninstall" { Uninstall-OpenVpnConnect }
    default { Show-Menu }
}
