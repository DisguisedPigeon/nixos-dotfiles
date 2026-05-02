{
  inputs,
  pkgs,
  lib,
  stdenv,
  writeShellScriptBin,
  brightnessctl,
  firefox,
  grim,
  playerctl,
  rofi,
  slurp,
  wezterm,
  wireplumber,
  wl-clip-persist,
  wl-clipboard,

  config ? {
    environment = { };
  },
}:
let
  host = stdenv.hostPlatform.system;

  has-noctalia = builtins.hasAttr "noctalia" inputs;
  noctalia = if has-noctalia then lib.getExe inputs.noctalia.packages.${host}.default else "";

  launcher-cmd =
    if has-noctalia then
      "${noctalia} ipc call launcher toggle"
    else
      "${lib.getExe rofi} -show drun -modi run,drun,ssh,window";
  term-cmd =
    if builtins.hasAttr "environment" config && builtins.hasAttr "term" config.environment then
      config.environment.term
    else
      lib.getExe wezterm;
  browser-pkg = if builtins.hasAttr "zen" inputs then inputs.zen.packages.${host}.beta else firefox;
  browser-cmd = lib.getExe browser-pkg;

  brightness-cmd = lib.getExe brightnessctl;
  player-cmd = lib.getExe playerctl;
  audio-cmd = lib.getExe' wireplumber "wpctl";
  region-selector = lib.getExe grim;
  pixel-data = lib.getExe slurp;
in
inputs.wrappers.wrappers.mangowc.wrap {
  inherit pkgs;

  sourcedFiles = [ ../resources/config/mango/config.conf ];

  extraConfig = ''
    exec-once = ${lib.getExe (
      writeShellScriptBin "mango-startup.sh" ''
        set +e

        noctalia-shell -d

        dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=mango
        systemctl --user restart xdg-desktop-portal &

        ${lib.getExe wl-clip-persist} --clipboard regular --reconnect-tries 0 &
        ${lib.getExe' wl-clipboard "wl-paste"} --type text --watch cliphist store &

      ''
    )}

    keymode = default

    # Launcher
    bind = SUPER,r,spawn,${launcher-cmd}

    # Term
    bind = SUPER,Return,spawn,${term-cmd}

    # Browser
    bind = SUPER,f,spawn,${browser-cmd} -P default
    # (music session)
    bind = SUPER,m,spawn,${browser-cmd} -P music

    # Quick dev access. Setup specific.
    bind = SUPER,space,spawn,wezterm start session-chooser

    keymode = common

    # Screenshot
    bind = SUPER+SHIFT,Print,spawn_shell,${region-selector} -g "$(${pixel-data} -d)" - | ${lib.getExe' wl-clipboard "wl-copy"}

    # Brightness
    bind = NONE,XF86MonBrightnessUp,spawn,${brightness-cmd} s +2%
    bind = SHIFT,XF86MonBrightnessUp,spawn,${brightness-cmd} s 100%
    bind = NONE,XF86MonBrightnessDown,spawn,${brightness-cmd} s 2%-
    bind = SHIFT,XF86MonBrightnessDown,spawn,${brightness-cmd} s 1%

    # Audio
    bind = NONE,XF86AudioRaiseVolume,spawn,${audio-cmd} set-volume @DEFAULT_SINK@ 5%+
    bind = NONE,XF86AudioLowerVolume,spawn,${audio-cmd} set-volume @DEFAULT_SINK@ 5%-
    bind = NONE,XF86AudioMute,spawn,${audio-cmd} set-mute @DEFAULT_SINK@ toggle
    bind = SHIFT,XF86AudioMute,spawn,${audio-cmd} set-mute @DEFAULT_SOURCE@ toggle

    # Playback
    bind = NONE,XF86AudioNext,spawn,${player-cmd} next
    bind = NONE,XF86AudioPrev,spawn,${player-cmd} previous
    bind = NONE,XF86AudioPlay,spawn,${player-cmd} play-pause

  ''
  + (
    if has-noctalia then
      ''
        # Laptop screen fold switch
        switchbind = fold,spawn,${noctalia} "lockScreen lock"
        switchbind = unfold,spawn,wlr-dpms on
      ''
    else
      ""
  );
}
