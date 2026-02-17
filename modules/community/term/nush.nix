{
  flake.aspects.nush.homeManager =
    { config, ... }:
    {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      programs.nushell = {
        enable = true;

        settings = {
          buffer_editor = "nvim";
          show_banner = false;
          edit_mode = "vi";
        };

        shellAliases = {
          ":q" = "exit";

          "git" = "echo no";

          n = "nvim";
          cat = "bat";

          # No reason not to sign commits, this probably is a git config. I haven't gotten to it for now.;
          "git commit" = "git commit -S";

          # gc = "git commit -S";

          # ga = "git add .";

          # gl = "git log --graph --pretty=format:'%Cred%h%C(yellow)%d%Creset - %Cblue%an%Creset - %Cgreen%s'";
          # gll = "git log --graph --pretty=format:'%Cred%H%C(yellow)%d%Creset - %Cblue%an%n%CgreenAuthor email: %ae%n%CgreenAuthor date: %ah%n%CgreenCommitter: %cn%n%CgreenCommitter email: %ce%n%CgreenCommit date: %ch%n%CgreenSigner: %GS%n%n%s%n%n%b'";

          # gpl = "git pull";
          # gps = "git push";

          # gs = "git status";

          # gst = "git stash";
          # gsp = "git stash pop";

          # gd = "git diff --staged";
        };

        extraConfig = ''
          # source starship.nu
          # source zoxide.nu

          $env.PROMPT_INDICATOR = "❯ "
          $env.PROMPT_INDICATOR_VI_INSERT = "❯ "
          $env.PROMPT_INDICATOR_VI_NORMAL = "❮ "
          $env.PROMPT_MULTILINE_INDICATOR = "   :"

          def hupdate [username?: string, host?: string] {
            home-manager --flake $".#(
              $username
              | default "${config.home.username}"
            )-(
              $host
              | default "${config.home.sessionVariables.host}"
            )" switch -b backup
          }

          def nupdate [host?: string] {
            sudo nixos-rebuild --flake .#(
              $host
              | default "${config.home.sessionVariables.host}"
            ) switch
          }

          def fupdate [username?: string, host?: string] {
            nix flake update
            nupdate $host
            hupdate $username $host
          }
        '';
      };
    };
}
