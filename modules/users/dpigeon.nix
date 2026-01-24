{ inputs, ... }:
{
  flake.modules.nixos.dpigeon =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      imports = [ inputs.self.modules.nixos.sops ];

      users = {
        mutableUsers = lib.mkDefault false;
        users.dpigeon = {
          shell = pkgs.bash;
          hashedPasswordFile = config.sops.secrets.user-password.path;
          isNormalUser = true;
          extraGroups = [
            "dpigeon"
            "user"
          ];
        };
      };

      programs.bash.interactiveShellInit = ''
        if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
          exec nu
        fi
      '';
    };

  flake.modules.homeManager.dpigeon-salt =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        # apps
        discord
        firefox
        kde-connect
        noctalia
        rofi
        thunderbird
        zen

        # nix
        sops
        stylix

        # services
        dunst

        # term
        bat
        eza
        fzf
        git
        nvim
        starship
        tmux
        wezterm
        zoxide
        # zsh
        nush

        # wms
        mango
        niri

        # other
        dpigeon-salt-extra-pkgs
      ];

      home.packages = [ pkgs.nushell ];
      home.sessionVariables.host = "salt";
      home.sessionVariables.EDITOR = "nvim";
      home.username = "dpigeon";
      home.homeDirectory = "/home/dpigeon";
      home.stateVersion = "25.05";
    };
}
