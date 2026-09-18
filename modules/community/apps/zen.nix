{ inputs, ... }:
{
  flake-file.inputs = {
    zen = {
      url = "github:0xc000022070/zen-browser-flake";
    };
  };

  flake.aspects.zen.homeManager =
    { pkgs, ... }:
    {
      imports = [ inputs.zen.homeModules.beta ];

      programs.zen-browser =
        let
          currentSystem = pkgs.stdenv.hostPlatform.system;
          policies =
            let
              mkExtensionSettings = builtins.mapAttrs (
                _: pluginId: {
                  install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
                  installation_mode = "force_installed";
                }
              );
            in
            {
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
              ExtensionSettings = mkExtensionSettings {
                "vimium-c@gdh1995.cn" = "vimium-c";
                "addon@darkreader.org" = "darkreader";
                "uBlock0@raymondhill.net" = "ublock-origin";
                "jid1-BoFifL9Vbdl2zQ@jetpack" = "decentraleyes";
                "{3579f63b-d8ee-424f-bbb6-6d0ce3285e6a}" = "chameleon-ext";
                "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
                "{74145f27-f039-47ce-a470-a662b129930a}" = "clearurls";
                "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons";
                "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = "return-youtube-dislikes";
                "{0d7cafdd-501c-49ca-8ebb-e3341caaa55e}" = "youtube-nonstop";
                "{34daeb50-c2d2-4f14-886a-7160b24d66a4}" = "youtube-shorts-block";
                "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = "refined-github-";
                "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = "styl-us";
              };
            };
        in
        {
          enable = true;
          inherit policies;
          package = inputs.zen.packages.${currentSystem}.beta;

          nativeMessagingHosts = [ ];

          profiles = {
            "default" = rec {
              bookmarks.force = true;
              pinsForce = true;
              search.force = true;
              spacesForce = true;
              containersForce = true;
              id = 0;

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
}
