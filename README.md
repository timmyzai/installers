# Timmy Installers

Simple VPN installer scripts for cloud servers, Linux machines, and Windows
clients.

This repository helps you set up a self-hosted VPN quickly with WireGuard,
wg-easy, or OpenVPN. It is useful for AWS EC2 Ubuntu VPN deployments, private
cloud access, remote admin access, lab environments, and personal secure tunnels.

## What Is Included

| Installer | Platform | Purpose |
| --- | --- | --- |
| `wireguard-install.sh` | Linux server | Install and manage WireGuard with wg-easy |
| `openvpn-install.sh` | Linux server | Install and manage an OpenVPN server |
| `wireguard-install-windows.ps1` | Windows client | Install WireGuard for Windows and import a client config |
| `openvpn-install-windows.ps1` | Windows client | Install OpenVPN Connect and import a client profile |

## Quick Start: AWS VPN On EC2 Ubuntu

Run these commands inside your EC2 Ubuntu server over SSH.

### WireGuard VPN With Timmy GitHub

```bash
curl -o wireguard-install.sh https://raw.githubusercontent.com/timmyzai/installers/refs/heads/main/wireguard-install.sh
chmod +x wireguard-install.sh
sudo ./wireguard-install.sh
```

### OpenVPN With Timmy GitHub

```bash
curl -o openvpn-install.sh https://raw.githubusercontent.com/timmyzai/installers/refs/heads/main/openvpn-install.sh
chmod +x openvpn-install.sh
sudo ./openvpn-install.sh
```

## Windows Client Install Commands

Run PowerShell as Administrator on your Windows PC.

### WireGuard For Windows

Install the Windows client helper:

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/refs/heads/main/wireguard-install-windows.ps1" `
  -OutFile "wireguard-install-windows.ps1"

Set-ExecutionPolicy -Scope Process Bypass -Force
.\wireguard-install-windows.ps1 -Action Install
```

Install WireGuard and import a client config:

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/refs/heads/main/wireguard-install-windows.ps1" `
  -OutFile "wireguard-install-windows.ps1"

Set-ExecutionPolicy -Scope Process Bypass -Force
.\wireguard-install-windows.ps1 `
  -Action InstallAndImport `
  -ConfigPath "$env:USERPROFILE\Downloads\client.conf"
```

### OpenVPN Connect For Windows

Install the Windows client helper:

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/refs/heads/main/openvpn-install-windows.ps1" `
  -OutFile "openvpn-install-windows.ps1"

Set-ExecutionPolicy -Scope Process Bypass -Force
.\openvpn-install-windows.ps1 -Action Install
```

Install OpenVPN Connect and import a client profile:

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/timmyzai/installers/refs/heads/main/openvpn-install-windows.ps1" `
  -OutFile "openvpn-install-windows.ps1"

Set-ExecutionPolicy -Scope Process Bypass -Force
.\openvpn-install-windows.ps1 `
  -Action InstallAndImport `
  -ConfigPath "$env:USERPROFILE\Downloads\client.ovpn"
```

## Recommended Flow

1. Create an Ubuntu EC2 instance or Linux server.
2. Open the required security group ports.
3. Run the WireGuard or OpenVPN Linux installer on the server.
4. Generate or download the client config from the server.
5. Run the matching Windows installer on your Windows PC.
6. Import the `.conf` or `.ovpn` file and connect.

## Common Ports

| VPN | Default Port | Protocol |
| --- | --- | --- |
| WireGuard | `51820` | UDP |
| wg-easy Admin UI | Installer prompt | TCP |
| OpenVPN | `1194` | UDP or TCP |

Only expose the ports you need. Keep admin interfaces private or protected by a
trusted network, VPN, load balancer, or firewall rule.

## Detailed Documentation

- [WireGuard Linux installer guide](wireguard-install-readme.md)
- [OpenVPN Linux installer guide](openvpn-install-readme.md)
- [WireGuard Windows installer guide](wireguard-install-windows-readme.md)
- [OpenVPN Windows installer guide](openvpn-install-windows-readme.md)

## Keywords

AWS VPN, EC2 Ubuntu VPN, WireGuard installer, wg-easy installer, OpenVPN
installer, Windows VPN client installer, self-hosted VPN, cloud VPN, private VPN,
Linux VPN server, PowerShell VPN installer.

## Safety Notice

Review every script before running it, especially on production servers or as
Administrator. VPN deployment affects networking, firewall rules, routing, and
remote access. You are responsible for validating security, compliance, and
operational impact in your own environment.

