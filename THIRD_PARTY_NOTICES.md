# Third-Party Notices

This repository contains installer and helper scripts only. It does not own,
bundle, or relicense the third-party VPN software that the scripts install or
configure.

## Project License

The scripts in this repository are licensed under the MIT License. See
[`LICENSE`](LICENSE).

## Upstream Software

| Software | How It Is Used | Upstream License / Terms |
| --- | --- | --- |
| WireGuard | Installed or configured for VPN tunneling | WireGuard components use GPLv2, MIT, BSD, Apache 2.0, or GPL depending on component and platform |
| WireGuard for Windows | Installed by the Windows WireGuard helper | MIT License |
| wg-easy | Used by the WireGuard Linux installer as the web UI and management layer | AGPL-3.0-only |
| OpenVPN Community Edition | Installed by the OpenVPN Linux installer | GPLv2 with OpenSSL linking exception |
| OpenVPN Connect | Installed by the Windows OpenVPN helper | Distributed by OpenVPN Inc. under its own application license and terms |
| Docker | Installed when needed for wg-easy deployment | Docker components have their own upstream licenses and terms |

## Trademarks

WireGuard, OpenVPN, Docker, Windows, Linux, Ubuntu, AWS, and other names may be
trademarks of their respective owners. This repository is not affiliated with,
endorsed by, or sponsored by those projects or companies.

## Upstream References

- WireGuard: https://www.wireguard.com/
- WireGuard for Windows: https://github.com/WireGuard/wireguard-windows
- wg-easy: https://github.com/wg-easy/wg-easy
- OpenVPN Community Edition: https://github.com/OpenVPN/openvpn
- OpenVPN legal and trademark terms: https://openvpn.net/legal/
- OpenVPN Connect: https://openvpn.net/client/

## Important

If you redistribute third-party binaries, Docker images, generated artifacts, or
modified upstream code, you must follow the license terms of those upstream
projects. The MIT License in this repository applies only to the installer and
helper scripts authored for this repository.
