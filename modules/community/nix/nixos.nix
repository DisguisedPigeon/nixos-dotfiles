{ self, ... }:
{
  flake.modules.nixos.nixos =
    { pkgs, ... }:
    {
      imports = [ self.modules.nixos.nix-settings ];
      environment.systemPackages = [ pkgs.neovim ];
    };
}
