# TimmyZai Cloud VPN Toolkit

One-command VPN setup for Linux, Ubuntu, AWS EC2, and Windows.

Use this toolkit to install WireGuard, wg-easy, or OpenVPN with clear copy-paste
commands. Linux and Ubuntu scripts prepare the VPN environment. Windows scripts
install the VPN app and can import the connection file created from Linux or
Ubuntu.

## Why Use This

- Fast setup for AWS EC2 Ubuntu and other Linux machines
- WireGuard / wg-easy and OpenVPN options
- Windows helpers for WireGuard and OpenVPN Connect
- Versioned install URLs with git tags
- MIT-licensed scripts with clear open-source notices
- Simple folder layout by VPN product and platform

## Linux / Ubuntu

Yes, this project supports Linux.

| Platform | Support |
| --- | --- |
| Ubuntu / Debian | Supported |
| RHEL / CentOS / Rocky / AlmaLinux / Fedora | Supported |
| Amazon Linux | Supported |

Best recommended target: AWS EC2 Ubuntu.

### WireGuard VPN On Linux / Ubuntu

```bash
curl -o wireguard-install.sh https://raw.githubusercontent.com/timmyzai/installers/refs/tags/v1.0.0/wireguard/linux/install.sh
chmod +x wireguard-install.sh
sudo ./wireguard-install.sh
```

### OpenVPN On Linux / Ubuntu

```bash
curl -o openvpn-install.sh https://raw.githubusercontent.com/timmyzai/installers/refs/tags/v1.0.0/openvpn/linux/install.sh
chmod +x openvpn-install.sh
sudo ./openvpn-install.sh
```

## Linux / Ubuntu Preparation

You usually do not need to run manual preparation commands first.

Run the installer with `sudo`. You do not need to switch into a root shell with
`sudo -i`.

The installers handle the required package installation. A full OS upgrade is
not forced because some users prefer to control when VM packages are upgraded.

For a fresh Ubuntu VM, this preparation is optional:

```bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release
```

Use it only if the VM is brand new, missing `curl`, or you want to update the OS
before running the VPN installer.

## After VM Setup: Create User And Connect

After you run a Linux / Ubuntu installer on a VM, you still need a connection
file for each device or user.

### WireGuard / wg-easy

1. Open the wg-easy admin page shown by the installer.
2. Create a client in wg-easy.
3. Download the WireGuard `.conf` file or use the QR code.
4. Import it into the WireGuard app on Windows, macOS, Linux, iOS, or Android.

Official references:

- [wg-easy documentation](https://wg-easy.github.io/wg-easy/)
- [WireGuard official install guide](https://www.wireguard.com/install/)
- [WireGuard official quick start](https://www.wireguard.com/quickstart/)
- [WireGuard for Windows](https://github.com/WireGuard/wireguard-windows)

### OpenVPN

1. Run the OpenVPN Linux / Ubuntu installer.
2. Create a client when the installer asks, or use the maintenance menu later.
3. Copy the generated `.ovpn` file to your device.
4. Import the `.ovpn` file into OpenVPN Connect.

Official references:

- [OpenVPN Connect user guide](https://openvpn.net/connect-docs/user-guide.html)
- [Import a profile in OpenVPN Connect](https://openvpn.net/connect-docs/import-profile.html)
- [OpenVPN Connect for Windows](https://openvpn.net/connect-docs/connect-for-windows.html)

## Windows

Windows uses the official VPN apps:

- WireGuard for Windows
- OpenVPN Connect

The Windows installer can do two things:

1. Install the VPN app only.
2. Install the VPN app and import your connection file.

Why import a connection file? The VPN app needs your unique connection settings,
keys, and endpoint address. For WireGuard this is usually `client.conf`. For
OpenVPN this is usually `client.ovpn`. You get this file after running the
Linux / Ubuntu setup.

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

## Typical Flow

1. Run the Linux / Ubuntu installer.
2. Create or download the VPN connection file.
3. Run the matching Windows installer.
4. Import the `.conf` or `.ovpn` file.
5. Connect from the Windows VPN app.

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
