> [!CAUTION]
> Cuestionable code quality ahead.

# Disguised Pigeon's NixOS Dotfiles
Flake-based with unstable channels. Usable enough for me.

### System Info:
- OS: NixOS (duh)
- DE: Hyprland, KDE plasma (Basic config), awesomewm (unconfigured)
- Shell: ZSH
- Terminal: Kitty/Konsole
- Editor: Neovim BTW

### Repo structure (might change)
- flake.nix: flake definition (Describes channels to get packages from and sources configurations)
- hosts/: System-wide configs. This includes user creation
- home/: User-specific configs (with home manager).

### Instalation instructinos
#### 0. Prerequisites
 - Functioning NixOS installation.
 - flakes and nix-command enabled (view [configuration.nix](./hosts/DPigeon-MacOS/configuration.nix#L36), `nix.settings.experimental-features`).

#### 1. Installation
```sh
git clone https://github.com/DisguisedPigeon/nixos-dotfiles.git /home/.nixos-dotfiles #This is where I store it.
cd /home/.nixos-dotfiles
```
at this point, this is now your config.

> [!WARNING]
> Before applying, you should switch:
> - [hardware-configuration.nix](./hosts/DPigeon-MacOS/hardware-configuration.nix) with your own 
> - Switch the references to the nixos-hardware repo in the [configuration.nix](./hosts/DPigeon/configuration.nix)
> These are machine-specific

> [!NOTE]
> As I'm a comedy genius, I called my NixOS host DPigeon-MacOS, you may change it to whatever you prefer in the [flake](flake.nix), the system-wide folder andthe [configuration file](./hosts/DPigeon-MacOS/configuration.nix#L27).
> There are two users defined atm, dpigeon and test. You can also create new ones or their names in the [flake](flake.nix), the [config file](./hosts/DPigeon-MacOS/configuration.nix) and the [per-user config](home/dpigeon/home.nix).
>
> The users should be reflected in all the files mentioned because of home-manager.

Here you should switch DPigeon-MacOS with your hostname (as defined in [flake.nix](flake.nix)). I also have defined an alias for dpigeon to apply nixos config (`nupdate`) and update the flake (`fupdate`) and another for both users to apply home manager config (`hupdate`)

###### System update
```sh
sudo nixos-rebuild --flake .#DPigeon-MacOS switch
```
###### User home update
```sh
home-manager --flake .#dpigeon@DPigeon-MacOS switch
```

###### Flake update
```sh
sudo nixos-rebuild --flake --upgrade .#DPigeon-MacOS switch
```

### Aditional notes
- This is a permanent WIP, do not expect stability from anything I make. I've deleted my nvim config and re-wrote it like 3 times in the past. Also, I often forget to push stuff. Oopsie.
- I use NixOS BTW
- I will probably forget updating this readme (LAST UPDATE: 19/9/2024), so success rate will probably get worse with time
- Unless in the future I update this (I did, but awesomewm is still not done), there probably are programs with incomplete configurations (also see first item). At the time of writing this, awesomewm is not configured at all.
- I use NeoVim BTW
- I don't expect nobody to use this, so if somebody is reading, I'm sorry for giving you the impression that installing this is a good idea. it's probably better for you to use another config (haven't tried it, but everything rxyhn makes is cool AF, so [rxyhn's yuki](https://github.com/rxyhn/yuki)).
