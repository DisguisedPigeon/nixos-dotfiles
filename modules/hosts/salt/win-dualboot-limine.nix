{
  flake.aspects.salt-dualboot.nixos = {
    boot.loader.limine.extraEntries = ''
      /Windows
      	protocol: efi
      	path: boot():/efi/Microsoft/Boot/bootmgfw.efi
    '';
  };
}
