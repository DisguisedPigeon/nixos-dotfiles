{
  pkgs,
  ...
}:
{
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  environment = {
    systemPackages = [
      pkgs.ntfs3g
    ];
  };
}
