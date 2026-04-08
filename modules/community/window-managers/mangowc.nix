{ inputs, ... }:
{
  flake-file.inputs = {
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
    wrappers.inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.mango.nixos =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        wl-clipboard

        brightnessctl
        playerctl
        wireplumber
      ];

      xdg.portal = {
        extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
        config.wlr.default = [
          "wlr"
          "gtk"
        ];
      };

      programs.mangowc = {
        enable = true;
        package = inputs.wrappers.wrappers.mangowc.wrap {
          inherit pkgs;

          sourcedFiles = [ ../../../resources/config/mango/config.conf ];

          extraContent =
            let
              host = pkgs.stdenv.hostPlatform.system;
              launcher =
                if (builtins.hasAttr "noctalia" inputs) then
                  let
                    noctalia-exe = lib.getExe inputs.noctalia.packages.${host}.default;
                  in
                  "${noctalia-exe} ipc call launcher toggle"
                else
                  let
                    rofi-exe = lib.getExe pkgs.rofi;
                  in
                  "${rofi-exe} -show drun -modi run,drun,ssh,window";
              term =
                if builtins.hasAttr "term" config.environment then
                  config.environment.term
                else
                  lib.getExe pkgs.wezterm;
              browser =
                if builtins.hasAttr "zen" inputs then
                  lib.getExe inputs.zen.packages.${host}.beta
                # I only support myself and furry browsers.
                # (maybe related to the -P trick only working on firefox-based)
                else
                  lib.getExe pkgs.firefox;

            in
            ''
              exec-once = ${lib.getExe (
                pkgs.writeShellScriptBin "mango-startup.sh" ''
                  set +e

                  ${lib.getExe pkgs.wl-clip-persist} --clipboard regular --reconnect-tries 0 &
                  wl-paste --type text --watch cliphist store &

                  noctalia-shell -d
                ''
              )}

              keymode = default
              # Launcher
              bind = SUPER,r,spawn,${launcher}
              # Term
              bind = SUPER,Return,spawn,${term}
              # Browser
              bind = SUPER,f,spawn,${browser} -P default
              # Screenshot
              bind = SUPER+SHIFT,Print,spawn_shell,${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp} -d)" - | wl-copy
              # Browser (music session)
              bind = SUPER,m,spawn,${browser} -P music

              # Quick dev access. Setup specific.
              bind = SUPER,space,spawn,wezterm start session-chooser
            '';
        };
      };
    };
}
