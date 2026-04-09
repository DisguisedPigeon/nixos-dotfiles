{
  inputs,
  pkgs,
}:
inputs.wrappers.wrappers.neovim.wrap {
  inherit pkgs;

  settings = {
    config_directory = ../resources/config/nvim;
    info_plugin_name = "nix-data";
  };

  specs.plugins = {
    data = with pkgs.vimPlugins; [
      oil-nvim
      nvim-lspconfig
      rose-pine
      mini-nvim
    ];
  };
}
