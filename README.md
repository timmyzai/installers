# Timmy Installers

Production-friendly installer scripts for self-hosted VPN setups on Linux
servers and Windows clients.

Use this repo to quickly deploy WireGuard, wg-easy, or OpenVPN on cloud servers
such as AWS EC2 Ubuntu, then install the matching Windows VPN client helper to
import your generated client profile.

## Installers

| Product | Server Installer | Windows Client Installer |
| --- | --- | --- |
| WireGuard / wg-easy | `wireguard/linux/install.sh` | `wireguard/windows/install.ps1` |
| OpenVPN | `openvpn/linux/install.sh` | `openvpn/windows/install.ps1` |

## Quick Start: AWS VPN On EC2 Ubuntu

Run these commands on your EC2 Ubuntu server over SSH.

### WireGuard VPN With Timmy GitHub

```bash
curl -o wireguard-install.sh https://raw.githubusercontent.com/timmyzai/installers/refs/heads/main/wireguard/linux/install.sh
chmod +x wireguard-install.sh
sudo ./wireguard-install.sh
```

### OpenVPN With Timmy GitHub

```bash
curl -o openvpn-install.sh https://raw.githubusercontent.com/timmyzai/installers/refs/heads/main/openvpn/linux/install.sh
chmod +x openvpn-install.sh
sudo ./openvpn-install.sh
```

## Windows Install Commands

Run PowerShell as Administrator.

### WireGuard For Windows

Install WireGuard:

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/refs/heads/main/wireguard/windows/install.ps1" `
  -OutFile "wireguard-install-windows.ps1"

Set-ExecutionPolicy -Scope Process Bypass -Force
.\wireguard-install-windows.ps1 -Action Install
```

Install WireGuard and import a client config:

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/refs/heads/main/wireguard/windows/install.ps1" `
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
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/refs/heads/main/openvpn/windows/install.ps1" `
  -OutFile "openvpn-install-windows.ps1"

Set-ExecutionPolicy -Scope Process Bypass -Force
.\openvpn-install-windows.ps1 -Action Install
```

Install OpenVPN Connect and import a client profile:

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/refs/heads/main/openvpn/windows/install.ps1" `
  -OutFile "openvpn-install-windows.ps1"

Set-ExecutionPolicy -Scope Process Bypass -Force
.\openvpn-install-windows.ps1 `
  -Action InstallAndImport `
  -ConfigPath "$env:USERPROFILE\Downloads\client.ovpn"
```

## Recommended Setup Flow

1. Create an Ubuntu EC2 instance or Linux server.
2. Open only the required security group or firewall ports.
3. Run the WireGuard or OpenVPN Linux installer on the server.
4. Generate or download the VPN client config.
5. Run the matching Windows installer on your Windows PC.
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
third-party VPN software from open-source projects including WireGuard, wg-easy,
and OpenVPN Community Edition. Each upstream project remains under its own
license and trademark terms.

The scripts in this repository are licensed under the MIT License. See
[`LICENSE`](LICENSE) and [`THIRD_PARTY_NOTICES.md`](THIRD_PARTY_NOTICES.md).

## Keywords

AWS VPN, EC2 Ubuntu VPN, WireGuard installer, wg-easy installer, OpenVPN
installer, Windows VPN client installer, self-hosted VPN, cloud VPN, private VPN,
Linux VPN server, PowerShell VPN installer.

## Safety Notice

Review every script before running it, especially on production servers or as
Administrator. VPN deployment affects networking, firewall rules, routing, and
remote access. You are responsible for validating security, compliance, and
operational impact in your own environment.
