# TimmyZai Cloud VPN Toolkit

Versioned installer scripts for setting up WireGuard / wg-easy and OpenVPN on
Linux or Ubuntu, with Windows helpers for installing VPN apps and importing
connection files.

Official VPN docs show how each product works. This toolkit focuses on a faster
guided setup for AWS EC2 Ubuntu, Linux VMs, and Windows clients.

## What You Get

| VPN | Linux / Ubuntu | Windows |
| --- | --- | --- |
| WireGuard / wg-easy | `wireguard/linux/install.sh` | `wireguard/windows/install.ps1` |
| OpenVPN | `openvpn/linux/install.sh` | `openvpn/windows/install.ps1` |

## Supported Platforms

| Platform | Status | Notes |
| --- | --- | --- |
| Ubuntu / Debian | Supported | Recommended for AWS EC2 Ubuntu |
| Amazon Linux | Supported | Package flow included |
| RHEL family | Supported | RHEL, CentOS, Rocky, AlmaLinux, Fedora |
| Windows | Supported | Installs client apps and imports connection files |

## Quick Start: Linux / Ubuntu

SSH into your Linux / Ubuntu VM and run one installer.

### WireGuard / wg-easy

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

## Linux / Ubuntu Preparation

Manual preparation is usually not required.

- Use `sudo ./<installer>.sh`; you do not need `sudo -i`.
- The installers handle required package installation.
- A full OS upgrade is not forced, because package upgrades are an operational choice.

Optional preparation for a fresh Ubuntu VM:

```bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release
```

## Create Users And Connect Devices

Each device or user needs a VPN connection file.

For WireGuard / wg-easy:

1. Open the wg-easy admin page shown by the installer.
2. Create a client in wg-easy.
3. Download the `.conf` file or scan the QR code.
4. Import it into the WireGuard app.

For OpenVPN:

1. Create a client during setup, or use the maintenance menu later.
2. Copy the generated `.ovpn` file to the device.
3. Import it into OpenVPN Connect.

Official references:

- [wg-easy documentation](https://wg-easy.github.io/wg-easy/latest/)
- [WireGuard install guide](https://www.wireguard.com/install/)
- [WireGuard quick start](https://www.wireguard.com/quickstart/)
- [WireGuard for Windows](https://github.com/WireGuard/wireguard-windows)
- [OpenVPN Connect user guide](https://openvpn.net/connect-docs/user-guide.html)
- [OpenVPN profile import guide](https://openvpn.net/connect-docs/import-profile.html)
- [OpenVPN Connect for Windows](https://openvpn.net/connect-docs/connect-for-windows.html)

## Windows

Run PowerShell as Administrator.

The Windows scripts can either install the VPN app only, or install the app and
import your connection file. The connection file contains your unique VPN
settings, keys, and endpoint address.

| VPN | Connection File |
| --- | --- |
| WireGuard | `client.conf` |
| OpenVPN | `client.ovpn` |

### WireGuard For Windows

Install WireGuard only:

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/refs/tags/v1.0.0/wireguard/windows/install.ps1" `
  -OutFile "wireguard-install-windows.ps1"

Set-ExecutionPolicy -Scope Process Bypass -Force
.\wireguard-install-windows.ps1 -Action Install
```

Install WireGuard and import `client.conf`:

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

Install OpenVPN Connect only:

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/refs/tags/v1.0.0/openvpn/windows/install.ps1" `
  -OutFile "openvpn-install-windows.ps1"

Set-ExecutionPolicy -Scope Process Bypass -Force
.\openvpn-install-windows.ps1 -Action Install
```

Install OpenVPN Connect and import `client.ovpn`:

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/refs/tags/v1.0.0/openvpn/windows/install.ps1" `
  -OutFile "openvpn-install-windows.ps1"

Set-ExecutionPolicy -Scope Process Bypass -Force
.\openvpn-install-windows.ps1 `
  -Action InstallAndImport `
  -ConfigPath "$env:USERPROFILE\Downloads\client.ovpn"
```

## Common Ports

| VPN | Default Port | Protocol |
| --- | --- | --- |
| WireGuard | `51820` | UDP |
| wg-easy Admin UI | Installer prompt | TCP |
| OpenVPN | `1194` | UDP or TCP |

Open only the ports you need. Keep admin interfaces protected by firewall rules,
a private network, VPN, or load balancer.

## Versioning

Current stable version: `v1.0.0`

Use tag-based URLs for repeatable installs:

```text
raw.githubusercontent.com/timmyzai/installers/refs/tags/v1.0.0/<path>
```

Use `refs/heads/main` only when you want the newest unreleased changes.

## License And Open Source Notice

The scripts in this repository are MIT licensed. See [`LICENSE`](LICENSE).

This project uses or installs third-party open-source VPN software including
WireGuard, wg-easy, and OpenVPN Community Edition. Each upstream project remains
under its own license and trademark terms. See
[`THIRD_PARTY_NOTICES.md`](THIRD_PARTY_NOTICES.md).

## Safety Notice

Review scripts before running them, especially on production machines or as
Administrator. VPN deployment affects networking, firewall rules, routing, and
remote access. You are responsible for validating security, compliance, and
operational impact in your own environment.
