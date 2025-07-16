{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
  };

  home.packages = with pkgs; [
    xclip
    ripgrep

    clang
    cmake

    nodePackages.prettier
    luajitPackages.jsregexp
    fd

    lua-language-server
    lua53Packages.luacheck
    stylua

    tree-sitter

    # Latex
    kdePackages.okular
  ];

  xdg.configFile.nvim = {
    enable = true;
    source = ./configs/nvim;
    recursive = true;
  };
}
