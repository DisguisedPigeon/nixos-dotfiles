{
  lib,
  config,
  ...
}:
{
  options = {
    starship-customization.enable = lib.mkEnableOption "enable starship customization";
    starship-customization.prefix = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "prefix for the prompt";
    };
  };
  config =
    let
      opts = config.starship-customization;
    in
    lib.mkIf opts.enable {
      programs.starship = {
        enable = true;
        settings = {
          format = "${opts.prefix}$all";

          aws = {
            symbol = "";
          };
          buf = {
            symbol = "";
          };
          c = {
            symbol = "";
          };
          conda = {
            symbol = "";
          };
          crystal = {
            symbol = "";
          };
          dart = {
            symbol = "";
          };
          gleam = {
            symbol = "󰦥 ";
          };
          directory = {
            read_only = " 󰌾";
          };
          docker_context = {
            symbol = "";
          };
          elixir = {
            symbol = "";
          };
          elm = {
            symbol = "";
          };
          fennel = {
            symbol = "";
          };
          fossil_branch = {
            symbol = "";
          };
          git_branch = {
            symbol = "";
          };
          git_status = {
            deleted = "";
            ahead = "";
            behind = "";
            diverged = "";
          };
          golang = {
            symbol = "";
          };
          guix_shell = {
            symbol = "";
          };
          haskell = {
            symbol = "";
          };
          haxe = {
            symbol = "";
          };
          hg_branch = {
            symbol = "";
          };
          hostname = {
            ssh_symbol = "";
          };
          java = {
            symbol = "";
          };
          julia = {
            symbol = "";
          };
          kotlin = {
            symbol = "";
          };
          lua = {
            symbol = "";
          };
          memory_usage = {
            symbol = "󰍛";
          };
          meson = {
            symbol = "󰔷";
          };
          nim = {
            symbol = "󰆥";
          };
          nix_shell = {
            symbol = "";
          };
          nodejs = {
            symbol = "";
          };
          ocaml = {
            symbol = "";
          };
          os.symbols = {
            NixOS = "";
            Windows = "󰍲";
          };
          package = {
            symbol = "󰏗";
          };
          perl = {
            symbol = "";
          };
          php = {
            symbol = "";
          };
          pijul_channel = {
            symbol = "";
          };
          python = {
            symbol = "";
          };
          rlang = {
            symbol = "󰟔";
          };
          ruby = {
            symbol = "";
          };
          rust = {
            symbol = "󱘗";
          };
          scala = {
            symbol = "";
          };
          swift = {
            symbol = "";
          };
          zig = {
            symbol = "";
          };
        };
      };
    };
}
