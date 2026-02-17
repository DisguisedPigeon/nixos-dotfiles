{
  flake.aspects.nush.homeManager =
    { config, ... }:
    {

      # Launch nushell when running an interactive bash session.
      # This is done to inherit the environment variables.
      programs.bash.initExtra = ''
        if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
          exec nu
        fi
      '';

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
