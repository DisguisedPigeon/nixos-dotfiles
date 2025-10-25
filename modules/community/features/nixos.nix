{ inputs, ... }:
{
  flake.modules.nixos.nixos =
    { pkgs, ... }:
    {
      imports = [
        inputs.self.modules.nixos.nix-settings
      ];
      environment.systemPackages = [
        pkgs.neovim
      ];
    };
}
