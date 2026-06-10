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

      programs.ssh = {
        enable = true;
        settings = {
          "pepper" = {
            HostName = "pepper";
            IdentityFile = "~/.ssh/pepper-git";
            User = "git";
            IdentitiesOnly = "yes";
          };
        };
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

        users = {
          groups.git = { };

          users.git = {
            group = "git";
            isNormalUser = true;
            createHome = true;
            homeMode = "700";

            openssh.authorizedKeys.keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF2usCLJudA5GvpM9UdDZJoxh+JUBeHcpWTVvyqHdTGn dpigeon@salt"
            ];
          };
        };
      };
  };
}
