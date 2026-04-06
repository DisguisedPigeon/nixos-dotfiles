let
  static-nix-conf-content = ''
    allowed-users = root dpigeon remotebuild
    builders =
    cores = 0
    experimental-features = nix-command flakes
    max-jobs = auto
    trusted-users = root dpigeon remotebuild
  '';
in
{
  flake.aspects.nix-settings = {
    nixos =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        system-features-static = "system-features = nixos-test benchmark kvm";
        system-features =
          if config.networking.hostName != "pepper" then
            system-features-static + " big-parallel
"
          else
            system-features-static + "";
        system-only-nix-conf-content = ''
          auto-optimise-store = true
          extra-platforms = aarch64-linux x86_64-linux
          http-connections = 128
          keep-derivations = false
          max-substitution-jobs = 128
          require-sigs = true
          sandbox = true
          sandbox-fallback = false
          extra-sandbox-paths = /run/binfmt
          trusted-public-keys = niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964= raspberry-pi-nix.cachix.org-1:WmV2rdSangxW0rZjY/tBvBDSaNFQ3DyEQsVw8EvHn9o= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
          use-xdg-base-directories = true
        ''
        + system-features;

        nix-conf-content = ''
          access-tokens = "github.com=${config.sops.placeholder.github-PAT}"
        ''
        + system-only-nix-conf-content
        + static-nix-conf-content;
      in
      {
        nixpkgs.config.allowUnfree = true;

        environment = {
          etc."nix/nix.conf".source = lib.mkForce config.sops.templates."nix.conf".path;
          systemPackages = [ pkgs.qemu ];
        };

        sops.templates."nix.conf" = {
          content = nix-conf-content;
          mode = "0644";
        };

        nix = {
          gc = {
            automatic = lib.mkDefault true;
            options = lib.mkDefault "-d";
            dates = lib.mkDefault "daily";
          };
          optimise = {
            automatic = lib.mkDefault true;
            dates = lib.mkDefault "daily";
          };
          channel.enable = lib.mkDefault false;
        };
      };
    homeManager =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      let
        nix-conf-content = ''
          access-tokens = "github.com=${config.sops.placeholder.github-PAT}
        ''
        + static-nix-conf-content;
      in
      {
        systemd.user.services.home-manager-auto-expire.Unit.After = [ "sops-nix.service" ];
        systemd.user.timers.nix-gc.Unit.After = [ "sops-nix.service" ];

        services.home-manager.autoExpire.enable = lib.mkDefault true;
        nixpkgs.config.allowUnfree = lib.mkDefault true;

        sops.templates."nix-conf" = {
          content = nix-conf-content;
          mode = "0644";
        };

        xdg.configFile."nix-conf" = {
          target = "nix/nix.conf";
          source = config.lib.file.mkOutOfStoreSymlink config.sops.templates."nix-conf".path;
        };

        nix = {
          package = lib.mkDefault pkgs.nix;
          gc = {
            automatic = lib.mkDefault true;
            options = lib.mkDefault "-d";
            dates = lib.mkDefault "daily";
          };
        };

        services.home-manager.autoExpire.timestamp = lib.mkDefault "-0 days";
      };
  };
}
