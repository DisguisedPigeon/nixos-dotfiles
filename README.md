> [!CAUTION]
> Cuestionable code quality ahead.

# Disguised Pigeon's NixOS Dotfiles
Flake-based franken-nix(?) with unstable and stable channels. Usable enough for me.

### System Info:
- OS: NixOS (duh)
- DE: KDE plasma (stock), Hyprland (incomplete atm), awesomewm (incomplete atm)
- Shell: ZSH (for user)
- Terminal: Kitty/Konsole
- Editor: NeoVim BTW

### Repo structure (might change)
- flake.nix: flake definition (describes the libraries and sourcefiles to be built)
- flake.lock: versions for the variables in te flake.nix
- configuration.nix: system-wide configs
- users/: user-specific configs (with home manager)

### Instalation instructinos
#### 0. Prerequisites
 - Functioning NixOS installation.
 - flakes and nix-command enabled (view [Configuration.nix](configuration.nix#L5), line 5).
 - git must be installed (package `git`).

#### 1. Installation
```sh
git clone https://github.com/DisguisedPigeon/nixos-dotfiles.git $HOME/nixos-dotfiles
cd $HOME/nixos-dotfiles
```
at this point you can delete the .git folder if you want, this is now your config.

> [!WARNING]
> Before applying,you should probably switch the [hardware configuration](hardware-configuration.nix) with your own and remove every reference to the nixos-hardware repo in the [flake](flake.nix), as these are hardware-specific.

> [!NOTE]
> As I'm a comedy genius, I called my host DPigeon-MacOS, you may change it to whatever you prefer in the [flake](flake.nix#L14), line 14 and in the [configuration file](configuration.nix#L27), line 27.
> The only defined user atm is dpigeon, you can also change it in the [flake](flake.nix#L32), the [config file](configuration.nix#L55) and the [per-user config](users/dpigeon-home.nix#L3-L4) 

Here you should switch DPigeon-MacOS with whatever hostname you set **in the flake.nix**
```sh
sudo nixos-rebuild --flake .#DPigeon-MacOS switch
```

### Aditional notes
- This is a permanent WIP, do not expect stability from anything I make. I've deleted my nvim config and re-wrote it like 3 times. Also, I often forget to push stuff. Oopsie.
- I use NixOS BTW
- I will probably forget updating this readme, so the specific line numbers will probably be wrong.
- Unless in the future I update this, there probably are programs with incomplete configurations (also see first item). At the time of writing this, at least Hyprland and Nvim (the second probably will be rewritten with NixVim)
- I use NeoVim BTW
- I don't expect nobody to use this, so if somebody is reading, I'm sorry for giving you the impression that installing this is a good idea. it's probably better for you to use another config (haven't tried it, but everything rxyhn makes is cool AF, so [rxyhn's yuki](https://github.com/rxyhn/yuki)).
