{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.asus-zephyrus-ga502
    # ./users.nix
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      # neovim-nightly-overlay.overlays.default
    ];

    config = {
      allowUnfree = true;
    };
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
        auto-optimise-store = true;
      };

      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 10d";
      };

      channel.enable = false;

      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  system.stateVersion = "24.05";
  # system.copySystemConfiguration = true;

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "DPigeon-MacOS";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "gl_ES.UTF-8";

  services = {
    xserver = {
      enable = true;
      xkb.layout = "es";
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };

    libinput.enable = true;

    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    xserver.windowManager.awesome.enable = true;
  };
  programs.hyprland.enable = true;
  programs.zsh.enable = true;

  environment = {
    systemPackages = [
      pkgs.neovim
      pkgs.git
      pkgs.home-manager
    ];
    variables = {
      EDITOR = "nvim";
      pathsToLink = [ "/share/zsh" ];
    };
  };

  users.users = {
    dpigeon = {
      shell = pkgs.zsh;
      initialPassword = "ligma";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

}
