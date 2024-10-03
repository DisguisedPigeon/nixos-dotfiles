{
  pkgs,
  ...
}:
{
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
