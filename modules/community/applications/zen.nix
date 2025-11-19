{ inputs, ... }:
{
  flake-file.inputs.zen = {
    url = "github:0xc000022070/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };

  flake.modules.homeManager.zen = {
    imports = [ inputs.zen.homeModules.beta ];
    programs.zen-browser = {
      enable = true;
      profiles = {
        "default" = {
          id = 0;
          spacesForce = true;
          spaces = {
            "Chill" = {
              id = "b0669194-0bb8-49c5-bb24-d65c6a6dde78";
              position = 1000;
              icon = "chrome://browser/skin/zen-icons/selectable/star-1.svg";
              theme = {
                type = "gradient";
                colors = [
                  {
                    red = 5;
                    green = 1;
                    blue = 191;
                    algorithm = "analogous";
                  }
                  {
                    red = 99;
                    green = 1;
                    blue = 191;
                    algorithm = "analogous";
                  }
                  {
                    red = 191;
                    green = 1;
                    blue = 188;
                    algorithm = "analogous";
                  }
                ];
                opacity = .4;
                texture = .0;
              };
            };
            "Work" = {
              id = "624786b0-7606-430a-a212-b0ba00dd18c7";
              position = 2000;
              icon = "chrome://browser/skin/zen-icons/selectable/briefcase.svg";
              theme = {
                type = "gradient";
                colors = [
                  {
                    red = 1;
                    green = 51;
                    blue = 31;
                    algorithm = "analogous";
                  }
                  {
                    red = 1;
                    green = 46;
                    blue = 51;
                    algorithm = "analogous";
                  }
                  {
                    red = 1;
                    green = 51;
                    blue = 6;
                    algorithm = "analogous";
                  }
                ];
                opacity = .2;
                texture = .0;
              };
            };
          };
          containersForce = true;
        };
        "music" = {
          id = 1;
          spacesForce = true;
          spaces = {
            "Music" = {
              id = "241fda1f-dedb-40d9-9058-077d04033c15";
              position = 3000;
              icon = "chrome://browser/skin/zen-icons/selectable/music.svg";
              theme = {
                type = "gradient";
                colors = [
                  {
                    red = 255;
                    green = 0;
                    blue = 0;
                    algorithm = "floating";
                  }
                ];
                opacity = .5;
                texture = .0;
              };
            };
          };
          containersForce = true;
        };
      };
    };
  };
}
