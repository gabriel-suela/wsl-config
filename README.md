# nixos-wsl

## Quickstart

- Get the [latest
  release](https://github.com/nix-community/NixOS-WSL/releases)
- Install it (tweak the command to your desired paths):

```powershell
wsl --import NixOS .\NixOS\ .\nixos-wsl.tar.gz --version 2
```

- Enter the distro:

```powershell
wsl -d NixOS
```
```bash
git clone https://github.com/gabriel-suela/wsl-config.git /tmp/configuration
cd /tmp/configuration
```
- Apply the configuration and shutdown the WSL2 VM
```bash
sudo nixos-rebuild switch --flake /tmp/configuration && sudo shutdown -h now
```

- Reconnect to the WSL2 VM

```bash
wsl -d NixOS
```

- `cd ~` and then `pwd` should now show `/home/<YOUR_USERNAME>`
- Move the configuration to your new home directory

```bash
mv /tmp/configuration ~/configuration
```
- Apply the configuration

```bash
sudo nixos-rebuild switch --flake ~/configuration
```
