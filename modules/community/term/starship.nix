{
  flake.aspects.starship.homeManager = {
    programs.starship = {
      enable = true;
      settings = {
        format = "$nix_shell$all";

        continuation_prompt = "   [:](white) ";
        character = {
          success_symbol = "  ";
          error_symbol = "[ ](bold red)";
        };

        hostname.ssh_symbol = " ";
        directory.read_only = "󰌾 ";
        cmd_duration = {
          format = "[ $duration]($style)";
        };
        docker_context = {
          format = "[$symbol$context]($style) ";
          symbol = " ";
        };
        direnv = {
          format = "\\[[$loaded]($style)|[$allowed]($style)\\] ";
          allowed_msg = "󰗠";
          not_allowed_msg = "󰋗";
          denied_msg = "󰅙";
          loaded_msg = "󰙨";
          unloaded_msg = "󰤑";
          disabled = false;
        };

        package = {
          format = "at [$symbol$version]($style) ";
          symbol = "󰏗 ";
        };

        aws = {
          format = "[$symbol($profile )(\($region\) )]($style)";
          symbol = " ";
        };
        c = {
          format = "[$symbol($version(-$name))]($style) ";
          symbol = " ";
        };
        elixir = {
          format = "[$symbol($version on otp $otp_version )]($style)";
          symbol = " ";
        };
        git_branch = {
          format = "@ [$symbol$branch(:$remote_branch)]($style) ";
          symbol = " ";
        };
        git_status = {
          ahead = "";
          behind = "";
          deleted = "x";
          diverged = "";
        };
        gleam = {
          format = "[$symbol($version)]($style) ";
          symbol = "󰦥 ";
        };
        golang = {
          format = "$symbol($version)]($style) ";
          symbol = " ";
        };
        haskell = {
          format = "[$symbol($version)]($style) ";
          symbol = " ";
        };
        java = {
          format = "[$symbol($version)]($style) ";
          symbol = " ";
        };
        lua = {
          format = "[$symbol($version)]($style) ";
          symbol = " ";
        };
        nix_shell = {
          format = "[$symbol](bold blue)";
          symbol = " ";
        };
        nodejs = {
          format = "[$symbol($version)]($style) ";
          symbol = " ";
        };
        ocaml = {
          format = "[$symbol($version )(\($switch_indicator$switch_name\) )]($style)";
          symbol = " ";
        };
        python = {
          format = "[$symbol$pyenv_prefix($version )(\($virtualenv\) )]($style)";
          symbol = " ";
        };
        rust = {
          format = "[$symbol($version)]($style) ";
          symbol = "󱘗 ";
        };
      };
    };
  };
}
