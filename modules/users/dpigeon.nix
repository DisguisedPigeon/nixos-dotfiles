{ inputs, ... }:
{
  flake.modules.nixos.dpigeon =
    { pkgs, config, ... }:
    #let
    #  containers-enabled = (config.virtualisation.podman.enable || config.virtualisation.docker.enable);
    #in
    {
      imports = [ inputs.self.modules.nixos.sops ];

      users.users.dpigeon = {
        shell = pkgs.bash;
        hashedPasswordFile = config.sops.secrets.user-password.path;
        isNormalUser = true;
        extraGroups = [
          "dpigeon"
          "wheel"
          "docker"
          "user"
        ]
        #++ (if containers-enabled then [ "docker" ] else [ ])
        ;
      };

    };

  flake.modules.homeManager.dpigeon-salt = {
    home.sessionVariables.host = "salt";
    home.username = "dpigeon";
    home.homeDirectory = "/home/dpigeon";
    home.stateVersion = "25.05";

    imports = with inputs.self.modules.homeManager; [
      # apps
      chromium
      discord
      emacs
      noctalia
      thunderbird
      zen

      # nix
      # sops # I'm not using it right now
      stylix

      # term
      bat
      direnv
      eza
      fzf
      git
      nush
      nvim
      starship
      tmux
      wezterm
      zoxide

      # wms
      mango
      # niri

      # other
      dpigeon-salt-extra-pkgs
    ];

  };
}
