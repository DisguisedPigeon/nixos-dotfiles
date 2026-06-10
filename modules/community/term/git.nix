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
          group = "git";
          isSystemUser = true;
          createHome = true;
          homeMode = "700";

          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF2usCLJudA5GvpM9UdDZJoxh+JUBeHcpWTVvyqHdTGn dpigeon@salt"
          ];
        };
      };
  };
}
