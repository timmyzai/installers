# TimmyZai Cloud VPN Toolkit

One-command VPN setup for Linux, Ubuntu, AWS EC2, and Windows.

Use this toolkit to install WireGuard, wg-easy, or OpenVPN with clear copy-paste
commands. Linux and Ubuntu scripts prepare the VPN environment. Windows scripts
install the VPN app and help import the generated client profile.

## Why Use This

- Fast setup for AWS EC2 Ubuntu and other Linux machines
- WireGuard / wg-easy and OpenVPN options
- Windows helpers for WireGuard and OpenVPN Connect
- Versioned install URLs with git tags
- MIT-licensed scripts with clear open-source notices
- Simple folder layout by VPN product and platform

## Platform Support

Yes, this project supports Linux.

| Platform | Supported By | Notes |
| --- | --- | --- |
| Ubuntu / Debian | `wireguard/linux/install.sh`, `openvpn/linux/install.sh` | Best fit for AWS EC2 Ubuntu |
| RHEL family | `wireguard/linux/install.sh`, `openvpn/linux/install.sh` | Includes RHEL, CentOS, Rocky, AlmaLinux, Fedora paths |
| Amazon Linux | `wireguard/linux/install.sh`, `openvpn/linux/install.sh` | Package flow is included in the scripts |
| Windows | `wireguard/windows/install.ps1`, `openvpn/windows/install.ps1` | Installs client apps and imports profiles |

Windows scripts do not create the VPN environment. They install the Windows VPN
app and import `.conf` or `.ovpn` files created from the Linux/Ubuntu setup.

## Installers

| VPN | Linux / Ubuntu | Windows |
| --- | --- | --- |
| WireGuard / wg-easy | `wireguard/linux/install.sh` | `wireguard/windows/install.ps1` |
| OpenVPN | `openvpn/linux/install.sh` | `openvpn/windows/install.ps1` |

## Versioning

Current stable version: `v1.0.0`

Use tag-based URLs for repeatable installs:

```text
https://raw.githubusercontent.com/timmyzai/installers/refs/tags/v1.0.0/<path>
```

Use `refs/heads/main` only when you want the newest unreleased changes.

## Quick Start: AWS VPN On EC2 Ubuntu

SSH into your EC2 Ubuntu machine, then run one of these installers.

### WireGuard VPN

```bash
curl -o wireguard-install.sh https://raw.githubusercontent.com/timmyzai/installers/refs/tags/v1.0.0/wireguard/linux/install.sh
chmod +x wireguard-install.sh
sudo ./wireguard-install.sh
```

### OpenVPN

```bash
curl -o openvpn-install.sh https://raw.githubusercontent.com/timmyzai/installers/refs/tags/v1.0.0/openvpn/linux/install.sh
chmod +x openvpn-install.sh
sudo ./openvpn-install.sh
```

## Windows Install Commands

Run PowerShell as Administrator.

### WireGuard For Windows

Install WireGuard:

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/refs/tags/v1.0.0/wireguard/windows/install.ps1" `
  -OutFile "wireguard-install-windows.ps1"

Set-ExecutionPolicy -Scope Process Bypass -Force
.\wireguard-install-windows.ps1 -Action Install
```

Install WireGuard and import a client config:

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/refs/tags/v1.0.0/wireguard/windows/install.ps1" `
  -OutFile "wireguard-install-windows.ps1"

Set-ExecutionPolicy -Scope Process Bypass -Force
.\wireguard-install-windows.ps1 `
  -Action InstallAndImport `
  -ConfigPath "$env:USERPROFILE\Downloads\client.conf"
```

### OpenVPN Connect For Windows

Install OpenVPN Connect:

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/refs/tags/v1.0.0/openvpn/windows/install.ps1" `
  -OutFile "openvpn-install-windows.ps1"

Set-ExecutionPolicy -Scope Process Bypass -Force
.\openvpn-install-windows.ps1 -Action Install
```

Install OpenVPN Connect and import a client profile:

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/refs/tags/v1.0.0/openvpn/windows/install.ps1" `
  -OutFile "openvpn-install-windows.ps1"

Set-ExecutionPolicy -Scope Process Bypass -Force
.\openvpn-install-windows.ps1 `
  -Action InstallAndImport `
  -ConfigPath "$env:USERPROFILE\Downloads\client.ovpn"
```

## Typical Flow

1. Create an AWS EC2 Ubuntu instance or Linux machine.
2. Open only the required firewall or security group ports.
3. Run the WireGuard or OpenVPN Linux installer.
4. Generate or download the VPN client profile.
5. Run the matching Windows installer.
6. Import the `.conf` or `.ovpn` file and connect.

## Common Ports

| VPN | Default Port | Protocol |
| --- | --- | --- |
| WireGuard | `51820` | UDP |
| wg-easy Admin UI | Installer prompt | TCP |
| OpenVPN | `1194` | UDP or TCP |

Keep admin interfaces private or protected by trusted firewall rules, a private
network, VPN, or load balancer.

## Open Source Notice

This repository contains installer and helper scripts. It uses or installs
third-party open-source VPN software including WireGuard, wg-easy, and OpenVPN
Community Edition. Each upstream project remains under its own license and
trademark terms.

The scripts in this repository are licensed under the MIT License. See
[`LICENSE`](LICENSE) and [`THIRD_PARTY_NOTICES.md`](THIRD_PARTY_NOTICES.md).

## Keywords

AWS VPN, EC2 Ubuntu VPN, Linux VPN installer, Ubuntu VPN setup, WireGuard
installer, wg-easy installer, OpenVPN installer, Windows VPN client installer,
self-hosted VPN, cloud VPN, private VPN, PowerShell VPN installer.

## Safety Notice

Review every script before running it, especially on production machines or as
Administrator. VPN deployment affects networking, firewall rules, routing, and
remote access. You are responsible for validating security, compliance, and
operational impact in your own environment.
