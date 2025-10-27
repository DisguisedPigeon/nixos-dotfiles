{
  flake.modules.nixos.nix-settings = {
    nixpkgs.config.allowUnfree = true;

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
