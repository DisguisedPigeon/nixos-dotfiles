{ inputs, ... }:
let
  flake.modules.nixos.pepper =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [ limine ];

      boot = {
        kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;

        loader = {
          grub.enable = false;
          generic-extlinux-compatible.enable = true;
        };
      };
    };
in
{
  inherit flake;
}
