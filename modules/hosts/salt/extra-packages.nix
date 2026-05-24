{
  flake.aspects.salt-extra-packages.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ntfs3g
        qemu
        noto-fonts
      ];
    };
}
