{
  pkgs,
  ...
}:
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

    nodePackages.prettier

    lua-language-server
    lua53Packages.luacheck
    stylua

  ];

  xdg.configFile.nvim = {
    enable = true;
    source = ./configs/nvim;
    recursive = true;
  };
}
