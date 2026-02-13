{
  flake.aspects.nix-settings = {
    nixos =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        nixpkgs.config.allowUnfree = true;

        environment = {
          etc."nix/nix.conf".source = lib.mkForce config.sops.templates."nix.conf".path;
          systemPackages = [ pkgs.qemu ];
        };

        sops.templates."nix.conf" = {
          content = ''
            access-tokens = "github.com=${config.sops.placeholder.github-PAT}
            allowed-users = root dpigeon
            auto-optimise-store = true
            builders =
            cores = 0
            experimental-features = nix-command flakes
            extra-platforms = aarch64-linux
            extra-sandbox-paths = /run/binfmt
            http-connections = 128
            keep-derivations = false
            max-jobs = auto
            max-substitution-jobs = 128
            require-sigs = true
            sandbox = true
            sandbox-fallback = false
            system-features = nixos-test benchmark big-parallel kvm
            substituters = https://niri.cachix.org?priority=1 https://nix-community.cachix.org?priority=2 https://aseipp-nix-cache.global.ssl.fastly.net?priority=3 https://cache.nixos.org?priority=4
            trusted-public-keys = niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
            trusted-users = root dpigeon
            use-xdg-base-directories = true
          '';
          mode = "0644";
        };

        nix = {
          gc = {
            automatic = true;
            options = "-d";
            dates = "daily";
          };
          optimise = {
            automatic = true;
            dates = "daily";
          };
          channel.enable = false;
        };
      };
    homeManager =
      { pkgs, ... }:
      {
        services.home-manager.autoExpire.enable = true;
        nixpkgs.config.allowUnfree = true;

        xdg.configFile."nix-sweep/presets.toml" = {
          text = ''
            [housekeeping]
            keep-min = 10
            remove-older = "14d"
            interactive = true
            gc = true
          '';
        };

        nix = {
          package = pkgs.nix;
          gc = {
            automatic = true;
            options = "-d";
            dates = "daily";
          };

          settings = {
            experimental-features = [
              "nix-command"
              "flakes"
            ];

            bash-prompt-prefix = ";\\[\\e[93m\\]DevShell\\[\\e[0m\\]-";
            bash-prompt = "\\[\\e[91m\\]\\h\\[\\e[0m\\]-\\[\\e[32m\\]\\u\\[\\e[0m\\]: \\[\\e[35m\\]\\w\\n\\[\\e[96;1m\\]> \\[\\e[0m\\]";
          };
        };

        services.home-manager.autoExpire.timestamp = "-0 days";
      };
  };
}
