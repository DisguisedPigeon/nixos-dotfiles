{
  flake.modules.nixos.nixos = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
