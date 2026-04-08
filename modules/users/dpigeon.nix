{ inputs, ... }:
{
  flake.modules.nixos.dpigeon =
    { config, lib, ... }:
    {
      imports = [ ];

      users.users.dpigeon = {
        hashedPasswordFile = lib.mkDefault config.sops.secrets.user-password.path;
        isNormalUser = lib.mkDefault true;
        extraGroups = lib.mkDefault [
          "dpigeon"
          "wheel"
          "docker"
          "podman"
          "user"
        ];
      };
    };

  flake.modules.homeManager.dpigeon-salt =
    { pkgs, ... }:
    {
      home.sessionVariables.host = "salt";
      home.username = "dpigeon";
      home.homeDirectory = "/home/dpigeon";
      home.stateVersion = "25.05";

      home.packages = (
        with pkgs;
        [
          gimp3
          obsidian
          tor
          vlc
        ]
      );

      imports = (
        with inputs.self.modules.homeManager;
        [
          # apps
          chromium
          discord
          emacs
          noctalia
          thunderbird
          zen

          # nix
          stylix
          sops

          # term
          bat
          direnv
          eza
          fzf
          git
          nush
          nvim
          starship
          wezterm
          zoxide

          # wms
          # niri
        ]
      );
      sops.secrets.github-PAT = { };

    };
}
