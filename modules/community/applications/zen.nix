{ inputs, ... }:
{
  flake-file.inputs.zen.url = "github:0xc000022070/zen-browser-flake";

  flake.modules.homeManager.zen = {
    imports = [ inputs.zen.homeModules.beta ];
    programs.zen-browser = {
      enable = true;
      profiles.default = {
        containersForce = true;
        containers.Personal = {
          color = "purple";
          icon = "fingerprint";
          id = 1;
        };
        containers.Work = {
          color = "blue";
          icon = "briefcase";
          id = 2;
        };
        containers.Shopping = {
          color = "green";
          icon = "dollar";
          id = 3;
        };
      };
    };
  };
}
