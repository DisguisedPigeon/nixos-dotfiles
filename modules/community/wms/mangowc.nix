{ inputs, ... }:
{
  flake-file.inputs.mango = {
    url = "github:DreamMaoMao/mangowc";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-parts.follows = "flake-parts";
  };

  flake.aspects.mango = {
    nixos = {
      imports = [ inputs.mango.nixosModules.mango ];

      programs.mango.enable = true;
    };

    homeManager =
      { pkgs, ... }:
      {
        imports = [ inputs.mango.hmModules.mango ];

        wayland.windowManager.mango.enable = true;
        # services.swaync.enable = true;

        home.packages = with pkgs; [
          swaybg
          wl-clip-persist
          wlsunset
          wl-clipboard
          xdg-desktop-portal
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
          grim
          slurp
        ];

        xdg.configFile."mango/wallpaper.png" = {
          enable = true;
          source = ../../../resources/wallpaper.png;
        };

        wayland.windowManager.mango = {
          autostart_sh = ''
            # see autostart.sh
            set +e

            # obs
            dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots &

            # night light
            wlsunset -l '42.9' -L '-8.5' &

            # keep clipboard content
            wl-clip-persist --clipboard regular --reconnect-tries 0 &

            # clipboard content manager
            wl-paste --type text --watch cliphist store &

            # Permission authentication
            /usr/lib/xfce-polkit/xfce-polkit &
            noctalia-shell -d
          '';

          settings = ''
            monitorrule=name:eDP-1, masterfactor:0.5, numbermasters:1, layout:scroller, transform:0, scale:1, x:0, y:0, width:1920, height:1080, refreshrate:120
            monitorrule=name:HDMI-A-1, masterfactor:0.5, numbermasters:1, layout:scroller, transform:0, scale:1, x:1920, y:0, width:1920, height:1080,  refreshrate:80

            # Window effect
            blur=1

            exec-once=~/.config/mango/autostart.sh

            border_radius=10

            animation_type_open=zoom
            animation_type_close=zoom

            scroller_default_proportion=0.5
            scroller_prefer_center=1
            edge_scroller_pointer_focus=0
            scroller_proportion_preset=0.5,1.0
            scroller_ignore_proportion_single=0

            default_mfact=0.7

            xkb_rules_layout=us
            xkb_rules_variant=altgr-intl

            trackpad_natural_scrolling=0

            gappih=20
            gappiv=20
            gappoh=25
            gappov=25
            borderpx=1
            rootcolor=0xf00f
            bordercolor=0xebbcbaff
            focuscolor=0xeb6f92ff
            maximizescreencolor=0xf6c177ff
            urgentcolor=0xc4a7e7ff
            scratchpadcolor=0x516c93ff
            globalcolor=0x31748fff
            overlaycolor=0x9ccfd8ff

            tagrule=id:1,layout_name:scroller
            tagrule=id:2,layout_name:scroller
            tagrule=id:3,layout_name:scroller
            tagrule=id:4,layout_name:scroller
            tagrule=id:5,layout_name:scroller
            tagrule=id:6,layout_name:scroller
            tagrule=id:7,layout_name:scroller
            tagrule=id:8,layout_name:tile
            tagrule=id:9,layout_name:tile

            bind=SUPER+SHIFT,R,reload_config

            # bind=SUPER,r,spawn,rofi -show drun -modi run,drun,ssh,window
            bind=SUPER,r,spawn,noctalia-shell ipc call launcher toggle
            bind=SUPER,Return,spawn,wezterm
            bind=SUPER,f,spawn,zen -P default
            bind=SUPER,m,spawn,zen -P music
            bind=SUPER+SHIFT,Print,spawn_shell,grim -g "$(slurp -d)" - | wl-copy
            bind=SUPER,space,spawn,wezterm start session-chooser

            bind=SUPER+SHIFT,Escape,quit
            bind=SUPER,w,killclient,

            bind=SUPER,h,focusdir,left
            bind=SUPER,l,focusdir,right
            bind=SUPER,k,focusdir,up
            bind=SUPER,j,focusdir,down

            bind=SUPER+SHIFT,k,exchange_client,up
            bind=SUPER+SHIFT,j,exchange_client,down
            bind=SUPER+SHIFT,h,exchange_client,left
            bind=SUPER+SHIFT,l,exchange_client,right

            bind=SUPER,Tab,toggleoverview,
            bind=SUPER,backslash,togglefloating,
            bind=SUPER,a,togglemaximizescreen,
            bind=SUPER+SHIFT,f,togglefullscreen,
            bind=SUPER,i,minimized,
            bind=SUPER,o,toggleoverlay,
            bind=SUPER+SHIFT,I,restore_minimized

            bind=SUPER,s,switch_proportion_preset,

            bind=SUPER,n,switch_layout

            bind=CTRL+SUPER,h,tagtoleft,0
            bind=CTRL+SUPER,l,tagtoright,0

            bind=SUPER,1,view,1,0
            bind=SUPER,2,view,2,0
            bind=SUPER,3,view,3,0
            bind=SUPER,4,view,4,0
            bind=SUPER,5,view,5,0
            bind=SUPER,6,view,6,0
            bind=SUPER,7,view,7,0
            bind=SUPER,8,view,8,0
            bind=SUPER,9,view,9,0

            bind=SUPER+SHIFT,1,tag,1,0
            bind=SUPER+SHIFT,2,tag,2,0
            bind=SUPER+SHIFT,3,tag,3,0
            bind=SUPER+SHIFT,4,tag,4,0
            bind=SUPER+SHIFT,5,tag,5,0
            bind=SUPER+SHIFT,6,tag,6,0
            bind=SUPER+SHIFT,7,tag,7,0
            bind=SUPER+SHIFT,8,tag,8,0
            bind=SUPER+SHIFT,9,tag,9,0

            bind=SUPER,Left,focusmon,left
            bind=SUPER,Right,focusmon,right
            bind=SUPER+SHIFT,Left,tagmon,left
            bind=SUPER+SHIFT,Right,tagmon,right

            bind=SUPER,G,togglegaps

            bind=SUPER+ALT,k,resizewin,+0,-50
            bind=SUPER+ALT,j,resizewin,+0,+50
            bind=SUPER+ALT,h,resizewin,-50,+0
            bind=SUPER+ALT,l,resizewin,+50,+0

            mousebind=SUPER,btn_left,moveresize,curmove
            mousebind=NONE,btn_middle,togglemaximizescreen,0
            mousebind=SUPER,btn_right,moveresize,curresize
          '';
        };
      };
  };
}
