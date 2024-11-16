# nixos-wsl-starter

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

- Go through all the `FIXME:` notices in `~/configuration` and make changes
  wherever you want
- Apply the configuration

```bash
sudo nixos-rebuild switch --flake ~/configuration
```

Note: If developing in Rust, you'll still be managing your toolchains and
components like `rust-analyzer` with `rustup`!

## Project Layout

In order to keep the template as approachable as possible for new NixOS users,
this project uses a flat layout without any nesting or modularization.

- `flake.nix` is where dependencies are specified
  - `nixpkgs` is the current release of NixOS
  - `nixpkgs-unstable` is the current trunk branch of NixOS (ie. all the
    latest packages)
  - `home-manager` is used to manage everything related to your home
    directory (dotfiles etc.)
  - `nur` is the community-maintained [Nix User
    Repositories](https://nur.nix-community.org/) for packages that may not
    be available in the NixOS repository
  - `nixos-wsl` exposes important WSL-specific configuration options
  - `nix-index-database` tells you how to install a package when you run a
    command which requires a binary not in the `$PATH`
- `wsl.nix` is where the VM is configured
  - The hostname is set here
  - The default shell is set here
  - User groups are set here
  - WSL configuration options are set here
  - NixOS options are set here
- `home.nix` is where packages, dotfiles, terminal tools, environment variables
  and aliases are configured
