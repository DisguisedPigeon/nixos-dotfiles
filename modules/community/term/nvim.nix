{
  flake.modules.homeManager.nvim =
    { pkgs, ... }:
    {
      programs.neovim = {
        enable = true;

        plugins = [ pkgs.vimPlugins.mini-deps ];
        vimAlias = true;
        vimdiffAlias = true;
        withNodeJs = true;
      };

      home.packages =
        (with pkgs; [
          ripgrep # file grepping
          fd # find but easier

          tree-sitter
        ])
        # Treesitter parsers
        ++ (with pkgs.vimPlugins.nvim-treesitter-parsers; [
          bash
          bibtex
          c
          cmake
          cpp
          css
          csv
          desktop
          diff
          dockerfile
          elixir
          erlang
          git_config
          git_rebase
          gitattributes
          gitcommit
          gitignore
          gleam
          go
          gomod
          heex
          html
          http
          java
          javadoc
          javascript
          jq
          jsdoc
          json
          json5
          latex
          lua
          luadoc
          make
          markdown
          markdown_inline
          mermaid
          nix
          ocaml
          ocaml_interface
          ocamllex
          python
          query
          regex
          rust
          sql
          ssh_config
          tmux
          typescript
          typespec
          typst
          vim
          vimdoc
          xcompose
          xml
          xresources
          yaml
          yuck
          zig
        ]);

      xdg.configFile.nvim = {
        enable = true;
        source = ../../../resources/config/nvim;
        recursive = true;
      };
    };
}
