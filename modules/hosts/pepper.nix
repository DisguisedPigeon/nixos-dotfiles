{ inputs, ... }:
let
  flake.modules.nixos.pepper =
    { pkgs, lib, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        dpigeon
        locale
        limine
        pepper-hardware
      ];

      users.users.dpigeon.shell = lib.mkForce pkgs.bashInteractive;
    };
in
{
  inherit flake;
}
