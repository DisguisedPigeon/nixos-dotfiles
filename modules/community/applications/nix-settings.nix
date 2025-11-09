{
  flake.modules.nixos.nix-settings =
    { config, lib, ... }:
    {
      nixpkgs.config.allowUnfree = true;

      sops.templates."nix.conf" = {
        content = ''
              access-tokens = "github.com=${config.sops.placeholder.github-pat} git.protagio.org=PAT:${config.sops.placeholder.protagio-pat}";
          allowed-users = *
          auto-optimise-store = true
          builders =
          cores = 0
          experimental-features = nix-command flakes
          http-connections = 128
          max-jobs = auto
          max-substitution-jobs = 128
          require-sigs = true
          sandbox = true
          sandbox-fallback = false
          # lower `priority` values get tried first
          substituters = https://niri.cachix.org https://niri.cachix.org?priority=3 https://cache.nixos.org/?priority=1 https://nix-community.cachix.org?priority=2 https://cache.nixos.org/
          system-features = nixos-test benchmark big-parallel kvm
          trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964= niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
          trusted-substituters =
          trusted-users = root dpigeon
          extra-platforms = aarch64-linux i686-linux
          extra-sandbox-paths = /run/binfmt /nix/store/ddg3d5ab6rbb9zkzjv10b72qy6ik4xcj-qemu-aarch64-binfmt-P-x86_64-unknown-linux-musl
        '';
        mode = "0644";
      };
      environment.etc."nix/nix.conf".source = lib.mkForce config.sops.templates."nix.conf".path;

      nix = {
        # Could be done by home manager's expiration too, but I'm suspicious in case it needs superuser
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

        settings = {
          keep-derivations = false;
          auto-optimise-store = true;

          experimental-features = [
            "nix-command"
            "flakes"
          ];

          use-xdg-base-directories = true;

          # [yellow]Devshell-
          bash-prompt-prefix = ";\\[\\e[93m\\]DevShell\\[\\e[0m\\]-";
          # [red]Host-[green]User: [purple]Directory\\n[cyan]> [base]
          bash-prompt = "\\[\\e[91m\\]\\h\\[\\e[0m\\]-\\[\\e[32m\\]\\u\\[\\e[0m\\]: \\[\\e[35m\\]\\w\\n\\[\\e[96;1m\\]> \\[\\e[0m\\]";
        };
      };
    };

  flake.modules.homeManager.nix-settings = {
    nixpkgs.config.allowUnfree = true;

    services.home-manager.autoExpire = {
      enable = true;
      timestamp = "-0 days";
    };
  };
}
