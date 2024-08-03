{config, lib, pkgs, pkgs-unstable, ...} : 
{
  home.username = "dpigeon";
  home.homeDirectory = "/home/dpigeon";

  home.packages = [
    pkgs.floorp
    pkgs.discord
    pkgs.amule
    pkgs.transmission-qt
    pkgs.syncplay
    pkgs.inkscape
    pkgs.vlc

    pkgs-unstable.rofi
    pkgs-unstable.maple-mono-NF
    pkgs-unstable.neovim
  ];

  programs.kitty = {
    enable = true;
    theme = "Tokyo Night Storm";
    font.name = "Maple Mono NF";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -lah";
      ga = "git add .";
      gc = "git commit";
      gl = "git log --graph --pretty=format:'%Cred%h%C(yellow)%d%Creset - %Cblue%an%Creset - %Cgreen%s'";
      gll = "git log --graph --pretty=format:'%Cred%H%C(yellow)%d%Creset - %Cblue%an%n%CgreenAuthor email: %ae%n%CgreenAuthor date: %ah%n%CgreenCommitter: %cn%n%CgreenCommitter email: %ce%n%CgreenCommit date: %ch%n%CgreenSigner: %GS%n%n%s%n%n%b'";
      nupdate = "sudo nixos-rebuild --flake .#DPigeon-MacOS switch";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$localip"
        "$shlvl"
        "$singularity"
        "$kubernetes"
        "$directory"
        "$vcsh"
        "$fossil_branch"
        "$fossil_metrics"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$hg_branch"
        "$pijul_channel"
        "$docker_context"
        "$package"
        "$c"
        "$cmake"
        "$cobol"
        "$daml"
        "$dart"
        "$deno"
        "$dotnet"
        "$elixir"
        "$elm"
        "$erlang"
        "$fennel"
        "$gleam"
        "$golang"
        "$guix_shell"
        "$haskell"
        "$haxe"
        "$helm"
        "$java"
        "$julia"
        "$kotlin"
        "$gradle"
        "$lua"
        "$nim"
        "$nodejs"
        "$ocaml"
        "$opa"
        "$perl"
        "$php"
        "$pulumi"
        "$purescript"
        "$python"
        "$quarto"
        "$raku"
        "$rlang"
        "$red"
        "$ruby"
        "$rust"
        "$scala"
        "$solidity"
        "$swift"
        "$terraform"
        "$typst"
        "$vlang"
        "$vagrant"
        "$zig"
        "$buf"
        "$nix_shell"
        "$conda"
        "$meson"
        "$spack"
        "$memory_usage"
        "$aws"
        "$gcloud"
        "$openstack"
        "$azure"
        "$nats"
        "$direnv"
        "$env_var"
        "$crystal"
        "$custom"
        "$sudo"
        "$line_break"
        "$jobs"
        "$battery"
        "$status"
        "$os"
        "$container"
        "$shell"
        "$character"
      ];

      right_format = lib.concatStrings [
        "$time - "
        "$cmd_duration"
      ];

    };
  };

  home.stateVersion = "24.05";

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind = [
      "$mod, F, exec, firefox"
    ];
  };


  programs.home-manager.enable = true;
}
