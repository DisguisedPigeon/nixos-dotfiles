{ inputs, ... }:
{
  flake-file.inputs.mango = {
    url = "github:DreamMaoMao/mangowc";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-parts.follows = "flake-parts";
  };

  flake.aspects.mango = {
    nixos =
      { lib, ... }:
      {
        imports = [ inputs.mango.nixosModules.mango ];

        programs.mango.enable = lib.mkDefault true;
      };

    homeManager =
      { pkgs, lib, ... }:
      {
        imports = [ inputs.mango.hmModules.mango ];

        wayland.windowManager.mango.enable = lib.mkDefault true;
        # services.swaync.enable = true;

        home.packages = with pkgs; [
          swaybg
          wl-clip-persist
          wlsunset
          wl-clipboard
          grim
          slurp
        ];
        xdg.portal = {
          extraPortals = lib.mkDefault [ pkgs.xdg-desktop-portal-wlr ];
          config.wlr.default = lib.mkDefault [
            "wlr"
            "gtk"
          ];
        };

        xdg.configFile."mango/wallpaper.png" = {
          enable = true;
          source = lib.mkDefault ../../../resources/wallpaper.png;
        };

        wayland.windowManager.mango = {
          autostart_sh = lib.mkDefault ''
            # see autostart.sh
            set +e

            noctalia-shell -d

            # obs
            dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots &

            # keep clipboard content
            wl-clip-persist --clipboard regular --reconnect-tries 0 &

            # clipboard content manager
            wl-paste --type text --watch cliphist store &

            # Permission authentication
            /usr/lib/xfce-polkit/xfce-polkit &
          '';

          settings = {
            monitorrule = [
              "name: eDP-1,    scale: 1, x: 0,    y: 0, width: 1920, height: 1080, refresh: 120, vrr: 1"
              "name: HDMI-A-1, scale: 1, x: 1920, y: 0, width: 1920, height: 1080, refresh: 80,  vrr: 1"
            ];
            blur = 1;
            border_radius = 10;
            animation_type_open = "zoom";
            animation_type_close = "zoom";
            scroller_default_proportion = 0.5;
            scroller_prefer_center = 1;
            edge_scroller_pointer_focus = 0;
            scroller_proportion_preset = "0.5,1.0";
            scroller_ignore_proportion_single = 0;
            default_mfact = 0.7;

            xkb_rules_layout = "us";
            xkb_rules_variant = "altgr-intl";
            trackpad_natural_scrolling = 0;
            gappih = 20;
            gappiv = 20;
            gappoh = 25;
            gappov = 25;
            borderpx = 1;
            rootcolor = "0xf00f";
            bordercolor = "0xebbcbaff";
            focuscolor = "0xeb6f92ff";
            maximizescreencolor = "0xf6c177ff";
            urgentcolor = "0xc4a7e7ff";
            scratchpadcolor = "0x516c93ff";
            globalcolor = "0x31748fff";
            overlaycolor = "0x9ccfd8ff";

            tagrule = [
              "id:1,layout_name:scroller"
              "id:2,layout_name:scroller"
              "id:3,layout_name:scroller"
              "id:4,layout_name:scroller"
              "id:5,layout_name:scroller"
              "id:6,layout_name:scroller"
              "id:7,layout_name:scroller"
              "id:8,layout_name:tile"
              "id:9,layout_name:tile"
            ];

            bind = [
              "SUPER+SHIFT,R,reload_config"
              "SUPER,r,spawn,rofi -show drun -modi run,drun,ssh,window"
              "SUPER,r,spawn,noctalia-shell ipc call launcher toggle"
              "SUPER,Return,spawn,wezterm"
              "SUPER,f,spawn,zen-beta -P default"
              "SUPER,m,spawn,zen-beta -P music"
              "SUPER+SHIFT,Print,spawn_shell,grim -g \"$(slurp -d)\" - | wl-copy"
              "SUPER,space,spawn,wezterm start session-chooser"
              "SUPER+SHIFT,Escape,quit"
              "SUPER,w,killclient,"
              "SUPER,h,focusdir,left"
              "SUPER,l,focusdir,right"
              "SUPER,k,focusdir,up"
              "SUPER,j,focusdir,down"
              "SUPER+SHIFT,k,exchange_client,up"
              "SUPER+SHIFT,j,exchange_client,down"
              "SUPER+SHIFT,h,exchange_client,left"
              "SUPER+SHIFT,l,exchange_client,right"
              "SUPER,Tab,toggleoverview,"
              "SUPER,backslash,togglefloating,"
              "SUPER,a,togglemaximizescreen,"
              "SUPER+SHIFT,f,togglefullscreen,"
              "SUPER,i,minimized,"
              "SUPER,o,toggleoverlay,"
              "SUPER+SHIFT,I,restore_minimized"
              "SUPER,s,switch_proportion_preset,"
              "SUPER,n,switch_layout"
              "CTRL+SUPER,h,tagtoleft,0"
              "CTRL+SUPER,l,tagtoright,0"
              "SUPER,1,view,1,0"
              "SUPER,2,view,2,0"
              "SUPER,3,view,3,0"
              "SUPER,4,view,4,0"
              "SUPER,5,view,5,0"
              "SUPER,6,view,6,0"
              "SUPER,7,view,7,0"
              "SUPER,8,view,8,0"
              "SUPER,9,view,9,0"
              "SUPER+SHIFT,1,tag,1,0"
              "SUPER+SHIFT,2,tag,2,0"
              "SUPER+SHIFT,3,tag,3,0"
              "SUPER+SHIFT,4,tag,4,0"
              "SUPER+SHIFT,5,tag,5,0"
              "SUPER+SHIFT,6,tag,6,0"
              "SUPER+SHIFT,7,tag,7,0"
              "SUPER+SHIFT,8,tag,8,0"
              "SUPER+SHIFT,9,tag,9,0"
              "SUPER,Left,focusmon,left"
              "SUPER,Right,focusmon,right"
              "SUPER+SHIFT,Left,tagmon,left"
              "SUPER+SHIFT,Right,tagmon,right"
              "SUPER,G,togglegaps"
              "SUPER+ALT,k,resizewin,+0,-50"
              "SUPER+ALT,j,resizewin,+0,+50"
              "SUPER+ALT,h,resizewin,-50,+0"
              "SUPER+ALT,l,resizewin,+50,+0"
            ];

            mousebind = [
              "SUPER,btn_left,moveresize,curmove"
              "NONE,btn_middle,togglemaximizescreen,0"
              "SUPER,btn_right,moveresize,curresize"
            ];
          };
        };
      };
  };
}
