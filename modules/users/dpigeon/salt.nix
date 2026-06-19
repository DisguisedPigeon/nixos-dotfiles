{ inputs, ... }:
{
  flake.aspects.dpigeon-salt.homeManager =
    { pkgs, ... }:
    {
      home = {
        sessionVariables.host = "salt";
        username = "dpigeon";
        homeDirectory = "/home/dpigeon";
        packages = with pkgs; [
          gimp3
          obsidian
          tor
          vlc
        ];
      };

      sops.secrets.github-PAT = { };

      imports = with inputs.self.modules.homeManager; [
        # apps
        chromium
        discord
        thunderbird
        zen

        # nix
        # stylix
        sops

        # term
        bat
        direnv
        eza
        fzf
        git
        nush
        starship
        wezterm
        zoxide
        fd
        rg
        rga
        treesitter
        ui-theming
      ];

      home.stateVersion = "25.05";
    };
}
