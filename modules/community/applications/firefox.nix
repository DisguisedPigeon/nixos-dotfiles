{ inputs, ... }:
let
  flake-file.inputs = {
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.homeManager.firefox =
    { pkgs, ... }:
    {
      programs.firefox = {
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
        };
        profiles = {
          "default" = rec {
            id = 0;
            extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
              ublock-origin
              clearurls
              decentraleyes
              chameleon-ext
            ];
            settings."extensions.autoDisableScopes" = 0;
            pinsForce = true;
            pins = {
              "Twitch" = {
                id = "f61acb53-804d-43f1-9794-1be5d479d2ed";
                workspace = spaces."Chill".id;
                url = "https://twitch.tv";
                position = 102;
              };
              "Youtube" = {
                id = "5065293b-1c04-40ee-ba1d-99a231873864";
                workspace = spaces."Chill".id;
                url = "https://www.youtube.com";
                position = 103;
              };
            };
            search = {
              force = true;
              default = "ddg";
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
        };
      };
    };
in
{
  inherit flake-file flake;
}
