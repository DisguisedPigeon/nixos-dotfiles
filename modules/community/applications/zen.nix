{ inputs, ... }:
{
  flake-file.inputs.zen = {
    url = "github:0xc000022070/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };

  flake.modules.homeManager.zen =
    { pkgs, ... }:
    let
      mkExtensionEntry =
        {
          id,
          pinned ? false,
        }:
        let
          base = {
            url = "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
            installation_mode = "force_installed";
          };
        in
        if pinned then base // { default_area = "navbar"; } else base;

      mkExtensionSettings = builtins.mapAttrs (
        _: entry: if builtins.isAttrs entry then entry else mkExtensionEntry { id = entry; }
      );

    in
    {
      imports = [ inputs.zen.homeModules.beta ];
      programs.zen-browser = {
        enable = true;
        nativeMessagingHosts = [ ];
        policies = {
          AutofillAddressEnabled = false;
          AutofillCreditCardEnabled = false;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          # NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
            EmailTracking = true;
            SuspectedFingerptinting = true;
            BaselineExceptions = true;
          };
          SanitizeOnShutdown = {
            FormData = true;
            Cache = true;
          };
          ExtensionSettings = mkExtensionSettings {
            "wappalyzer@crunchlabz.com" = "wappalyzer";
            "uBlock0@raymondhill.net" = "ublock-origin";
            "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons";
            "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = "return-youtube-dislikes";
            "{74145f27-f039-47ce-a470-a662b129930a}" = "clearurls";
            "github-no-more@ihatereality.space" = "github-no-more";
            "@searchengineadremover" = "searchengineadremover";
            "jid1-BoFifL9Vbdl2zQ@jetpack" = "decentraleyes";
            "trackmenot@mrl.nyu.edu" = "trackmenot";
            "{861a3982-bb3b-49c6-bc17-4f50de104da1}" = "custom-user-agent-revived";
            "{3579f63b-d8ee-424f-bbb6-6d0ce3285e6a}" = "chameleon-ext";
          };
        };
        profiles = {
          "default" = rec {
            id = 0;
            settings = {
              "zen.workspaces.continue-where-left-off" = true;
              "zen.view.compact.hide-tabbar" = true;
              "zen.view.compact.hide-toolbar" = true;
              "zen.view.compact.animate-sidebar" = false;
              "zen.welcome-screen.seen" = true;
              "zen.urlbar.behavior" = "float";
            };
            bookmarks = {
              force = true;
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
            pinsForce = true;
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
              force = true;
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
            containersForce = true;
          };
          "music" = rec {
            id = 1;
            pinsForce = true;
            pins = {
              "YTM" = {
                id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
                url = "https://music.youtube.com";
                position = 101;
                workspace = spaces."Music".id;
                isEssential = true;
              };
            };
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
                  opacity = 0.5;
                };
              };
            };
            containersForce = true;
          };
        };
      };
    };
}
