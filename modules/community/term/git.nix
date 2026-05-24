{ inputs, ... }:
{
  flake.aspects = {
    git = {
      nixos =
        { pkgs, ... }:
        let
          wrapped-git = pkgs.callPackage ../../../packages/wrapped-git.nix { inherit inputs; };
          wrapped-jj = pkgs.callPackage ../../../packages/wrapped-jj.nix { inherit inputs; };
        in
        {
          environment.systemPackages = [ wrapped-jj ];
          programs.git = {
            enable = true;
            package = wrapped-git;
          };

          # fix for jujutsu pager
          environment.variables.PAGER = null;
        };

      homeManager = {
        xdg.configFile."git/config".text = ''
          [maintenance]
          repo = "~/nixos-dotfiles"
        '';
      };
    };
    git-server.nixos =
      { pkgs, ... }:
      let
        wrapped-git = pkgs.callPackage ../../../packages/wrapped-git.nix { inherit inputs; };
      in
      {
        programs.git = {
          enable = true;
          package = wrapped-git;
        };

        users.groups.git = { };
        users.users.git = {
          description = "User accessible for a ssh git server.";
          isSystemUser = true;
          group = "git";
          useDefaultShell = false;
          shell = "sh";
          createHome = true;
          homeMode = "700";
        };

        # fix for jujutsu pager
        environment.variables.PAGER = null;
      };
  };
}
