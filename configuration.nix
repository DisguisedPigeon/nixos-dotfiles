{ pkgs, pkgs-unstable, ... }:

{
  # Nix internal settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 30d";
  };
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
  # system.copySystemConfiguration = true;

  # Bootloader
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Network related stuff
  networking.hostName = "DPigeon-MacOS";
  networking.networkmanager.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  #Localization
  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "gl_ES.UTF-8";

  # DE stuff
  services.xserver.enable = true;
  services.xserver.xkb.layout = "es";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  services.libinput.enable = true;

  # WMs
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.windowManager.awesome.enable = true;
  programs.hyprland.enable = true;

  # Users
  users.users.dpigeon = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
   };

  #System-wide packages
  environment.systemPackages = [
    pkgs.wget
    pkgs.git
    pkgs.gcc
    pkgs.zip
    pkgs.unzip
    pkgs.zsh

    pkgs-unstable.neovim
    pkgs-unstable.cargo
    pkgs-unstable.ripgrep
    pkgs-unstable.fd
    pkgs-unstable.nodejs_22
    pkgs-unstable.go
    pkgs-unstable.python312
    pkgs-unstable.python312Packages.pip
    pkgs-unstable.luajitPackages.luarocks
  ];

  programs.zsh.enable = true;


  environment.variables.EDITOR = "nvim";
  environment.pathsToLink = [ "/share/zsh" ];
}

