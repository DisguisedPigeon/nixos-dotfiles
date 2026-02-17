{ inputs, ... }:
{
  flake.modules.nixos.dpigeon =
    { pkgs, config, ... }:
    let
      containers-enabled = (config.virtualisation.podman.enable || config.virtualisation.docker.enable);
    in
    {
      imports = [ inputs.self.modules.nixos.sops ];

      users.users.dpigeon = {
        shell = pkgs.bash;
        hashedPasswordFile = config.sops.secrets.user-password.path;
        isNormalUser = true;
        extraGroups = [
          "dpigeon"
          "wheel"
          "user"
        ]
        ++ (if containers-enabled then [ "docker" ] else [ ]);
      };

    };

  flake.modules.homeManager.dpigeon-salt = {
    home.sessionVariables.host = "salt";
    home.username = "dpigeon";
    home.homeDirectory = "/home/dpigeon";
    home.stateVersion = "25.05";

    imports = with inputs.self.modules.homeManager; [
      # apps
      discord
      noctalia
      emacs
      thunderbird
      zen

      # nix
      stylix
      # sops # I'm not using it right now

      # services
      # dunst # noctalia shell already handles notifications

      # term
      wezterm
      nush
      zoxide
      direnv
      bat
      eza
      fzf
      git
      nvim
      starship
      tmux

      # wms
      mango
      niri

      # other
      dpigeon-salt-extra-pkgs
    ];

  };
}
