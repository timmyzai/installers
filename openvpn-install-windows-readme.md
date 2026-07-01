# OpenVPN Connect Windows Installer

Companion Windows client installer for `openvpn-install.sh`.

The Linux script installs and manages the OpenVPN server and generates `.ovpn`
client profiles. This PowerShell script is for Windows client machines. It
installs OpenVPN Connect and can import a generated `.ovpn` profile.

## What It Does

- Installs OpenVPN Connect with `winget`
- Supports optional package version pinning
- Imports a `.ovpn` profile through the OpenVPN Connect CLI
- Opens OpenVPN Connect after import
- Supports uninstall through `winget`

## Requirements

- Windows 10 1809 or newer, Windows 11, or supported Windows Server
- PowerShell 5.1 or newer
- Administrator PowerShell session
- `winget` / Microsoft App Installer
- An OpenVPN `.ovpn` client profile from the Linux OpenVPN server

## Install Only

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/main/openvpn-install-windows.ps1" `
  -OutFile "openvpn-install-windows.ps1"

Set-ExecutionPolicy -Scope Process Bypass -Force
.\openvpn-install-windows.ps1 -Action Install
```

## Install And Import Client Profile

```powershell
.\openvpn-install-windows.ps1 `
  -Action InstallAndImport `
  -ConfigPath "C:\Users\you\Downloads\client.ovpn"
```

## Pin A Specific Package Version

```powershell
.\openvpn-install-windows.ps1 `
  -Action Install `
  -PackageVersion "3.9.0"
```

If `-PackageVersion` is omitted, `winget` installs the current package version
available from the Windows Package Manager source.

## Import With A Custom Profile Name

```powershell
.\openvpn-install-windows.ps1 `
  -Action Import `
  -ConfigPath "C:\Users\you\Downloads\client.ovpn" `
  -ProfileName "Office VPN"
```

## Replace Existing Profile

```powershell
.\openvpn-install-windows.ps1 `
  -Action Import `
  -ConfigPath "C:\Users\you\Downloads\client.ovpn" `
  -ProfileName "Office VPN" `
  -Force
```

## Uninstall

```powershell
.\openvpn-install-windows.ps1 -Action Uninstall
```

## Notes

- This script does not create an OpenVPN server on Windows.
- Use `openvpn-install.sh` on the Linux server first.
- Keep `.ovpn` files private. They usually contain client certificates and keys.
- Review scripts before running them as Administrator.
