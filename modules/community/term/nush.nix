{
  flake.aspects.nush.homeManager =
    { config, ... }:
    {

      # Launch nushell when running an interactive bash session.
      # This is done to inherit the environment variables.
      programs.bash = {
        enable = true;
        initExtra = ''
          if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
            exec nu
          fi
        '';
      };

      programs.carapace = {
        enable = true;
        enableNushellIntegration = true;
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
        };

        extraConfig = ''
          # Prompt config - for starship -------------------------------------------------------------
          $env.PROMPT_INDICATOR = "❯ "
          $env.PROMPT_INDICATOR_VI_INSERT = "❯ "
          $env.PROMPT_INDICATOR_VI_NORMAL = "❮ "
          $env.PROMPT_MULTILINE_INDICATOR = "   :"


          # Path extensions --------------------------------------------------------------------------
          $env.PATH = $env.PATH
            | split row (char esep)
            | prepend /home/myuser/.apps
            | append /usr/bin/env


          # LS aliases -------------------------------------------------------------------------------
          def lla [...args] { ls -la ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
          def la  [...args] { ls -a  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
          def ll  [...args] { ls -l  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
          def l   [...args] { ls     ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }


          # Completion -------------------------------------------------------------------------------
          let carapace_completer = {|spans: list<string>|
            carapace $spans.0 nushell ...$spans
            | from json
            | ( if (
                  $in
                  | default []
                  | where value == $"($spans | last)ERR"
                  | is-empty
                ) { $in }
                else { null })
          }
          $env.CARAPACE_BRIDGES = 'zsh,bash,inshellisense'

          let zoxide_completer = {|spans|
              $spans
              | skip 1
              | zoxide query -l ...$in
              | lines
              | where {|x| $x != $env.PWD}
          }

          let multiple_completers = {|spans|
            let expanded_alias = scope aliases
              | where name == $spans.0
              | get -o 0.expansion

            let spans = if $expanded_alias != null {
              $spans
              | skip 1
              | prepend ($expanded_alias | split row ' ' | take 1)
            } else { $spans }

            match $spans.0 {
              __zoxide_z | __zoxide_zi => $zoxide_completer
              _ => $carapace_completer
            } | do $in $spans
          }

          $env.config = {
            show_banner: false,
            completions: {
              case_sensitive: false
              quick: true
              partial: true
              algorithm: "fuzzy"
              external: {
                enable: true
                max_results: 100
                completer: $multiple_completers
              }
            }
          }


          # NixOS/Home manager aliases ---------------------------------------------------------------
          def hupdate [username?: string, host?: string] {
            let username: string = $username | default "${config.home.username}"
            let host: string = $host | default "${config.home.sessionVariables.host}"

            home-manager --flake $".#($username)-($host)" switch -b backup
          }

          def nupdate [host?: string] {
            let host: string = $host | default "${config.home.sessionVariables.host}"

            sudo nixos-rebuild --flake .#($host) switch
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
