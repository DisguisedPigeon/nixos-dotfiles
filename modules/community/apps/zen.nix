{ inputs, ... }:
let

  flake.aspects.zen.homeManager =
    { pkgs, ... }:
    let
      currentSystem = pkgs.stdenv.hostPlatform.system;
    in
    {
      imports = [ inputs.zen.homeModules.beta ];

      programs.zen-browser =
        let
          policies = {
            AutofillAddressEnabled = false;
            AutofillCreditCardEnabled = false;
            DisableAppUpdate = true;
            DisableFeedbackCommands = true;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DontCheckDefaultBrowser = true;
            EnableTrackingProtection = {
              Value = true;
              Locked = true;
              Cryptomining = true;
              Fingerprinting = true;
              EmailTracking = true;
              SuspectedFingerptinting = true;
              BaselineExceptions = true;
            };
            # NoDefaultBookmarks = true;
            OfferToSaveLogins = false;
            SanitizeOnShutdown = {
              FormData = true;
              Cache = true;
            };
          };
          extensions.packages = with inputs.firefox-addons.packages.${currentSystem}; [
            chameleon-ext
            clearurls
            decentraleyes
            ublock-origin
            ublock-origin
            github-file-icons
            return-youtube-dislikes
            clearurls
            decentraleyes
            chameleon-ext
            youtube-nonstop
            youtube-shorts-block
            ublock-origin
            refined-github
            github-file-icons
            return-youtube-dislikes
            clearurls
            decentraleyes
            chameleon-ext
          ];
        in
        {
          enable = true;
          inherit policies;

          nativeMessagingHosts = [ ];

          profiles = {
            "default" = rec {
              bookmarks.force = true;
              pinsForce = true;
              search.force = true;
              spacesForce = true;
              containersForce = true;
              id = 0;
              inherit extensions;

              settings = {
                "extensions.autoDisableScopes" = 0;
                "zen.workspaces.continue-where-left-off" = true;
                "zen.view.compact.hide-tabbar" = true;
                "zen.view.compact.hide-toolbar" = true;
                "zen.view.compact.animate-sidebar" = false;
                "zen.welcome-screen.seen" = true;
                "zen.urlbar.behavior" = "float";
              };
              bookmarks = {
                settings = [
                  {
                    name = "Nix sites";
                    toolbar = true;
                    bookmarks = [
                      {
                        name = "pkgs";
                        url = "https://search.nixos.org/packages?channel=unstable";
                      }
                      {
                        name = "opts";
                        url = "https://search.nixos.org/options?channel=unstable";
                      }
                      {
                        name = "hm opts";
                        url = "https://home-manager-options.extranix.com/?query=&release=master";
                      }
                      {
                        name = "wiki";
                        url = "https://wiki.nixos.org/";
                      }
                    ];
                  }
                ];
              };
              pins = {
                "GitHub" = {
                  id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
                  url = "https://github.com";
                  position = 101;
                  isEssential = true;
                };
                "Youtube" = {
                  id = "5065293b-1c04-40ee-ba1d-99a231873864";
                  workspace = spaces."Chill".id;
                  url = "https://www.youtube.com";
                  position = 103;
                };
                "UDC" = {
                  id = "2855cb7f-8b0d-4b38-88cf-3cede1379e6b";
                  workspace = spaces."Work".id;
                  url = "https://udconline.udc.gal/";
                  position = 104;
                };
              };
              search = {
                default = "ddg";
                engines = {
                  "Nix Wiki" = {
                    urls = [
                      {
                        template = "https://wiki.nixos.org/w/index.php";
                        params = [
                          {
                            name = "title";
                            value = "Special:Search";
                          }
                          {
                            name = "search";
                            value = "{searchTerms}";
                          }
                        ];
                      }
                    ];
                    definedAliases = [ "nw" ];
                  };
                  "Nix Packages" = {
                    urls = [
                      {
                        template = "https://search.nixos.org/packages";
                        params = [
                          {
                            name = "type";
                            value = "packages";
                          }
                          {
                            name = "channel";
                            value = "unstable";
                          }
                          {
                            name = "query";
                            value = "{searchTerms}";
                          }
                        ];
                      }
                    ];
                    definedAliases = [ "np" ];
                  };
                  "Nix Options" = {
                    urls = [
                      {
                        template = "https://search.nixos.org/options";
                        params = [
                          {
                            name = "channel";
                            value = "unstable";
                          }
                          {
                            name = "query";
                            value = "{searchTerms}";
                          }
                        ];
                      }
                    ];
                    definedAliases = [ "nop" ];
                  };
                  "Home Manager Options" = {
                    urls = [
                      {
                        template = "https://home-manager-options.extranix.com/";
                        params = [
                          {
                            name = "query";
                            value = "{searchTerms}";
                          }
                          {
                            name = "release";
                            value = "master"; # unstable
                          }
                        ];
                      }
                    ];
                    definedAliases = [ "hop" ];
                  };
                };
              };
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
                    opacity = 0.4;
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
                    opacity = 0.2;
                  };
                };
              };
            };
            "music" = rec {
              id = 1;
              inherit extensions;

              pinsForce = true;
              search.force = true;
              spacesForce = true;
              containersForce = true;

              settings = {
                "extensions.autoDisableScopes" = 0;
                "zen.workspaces.continue-where-left-off" = true;
                "zen.view.compact.hide-tabbar" = true;
                "zen.view.compact.hide-toolbar" = true;
                "zen.view.compact.animate-sidebar" = false;
                "zen.welcome-screen.seen" = true;
                "zen.urlbar.behavior" = "float";
              };

              search.default = "ddg";
              pins."YTM" = {
                id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
                url = "https://music.youtube.com";
                position = 101;
                workspace = spaces."Music".id;
                isEssential = true;
              };
              spaces."Music" = {
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
                  opacity = 0.5;
                };
              };
            };
          };
        };
    };
in
{
  flake-file.inputs = {
    zen = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  inherit flake;
}
