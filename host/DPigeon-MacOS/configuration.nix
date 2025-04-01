{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.asus-zephyrus-ga502
    ./hardware-configuration.nix
    ../modules/system-setup.nix
  ];
  # --- Custom modules config ---
  dev.enable = true;
  dualboot.enable = true;
  graphics = {
    enable = true;
    desktops = {
      plasma = true;
      awesome = true;
    };
  };

  services.flatpak.enable = true;
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
    kernelModules = [
      "v4l2loopback"
    ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';
  };
  environment.systemPackages = [
    pkgs.v4l-utils
  ];

  laptop.enable = true;
  stylix.enable = true;
  test-user.enable = true;
  general.hostname = "DPigeon-MacOS";

  services.kanata = {
    enable = true;
    keyboards.default = {
      extraDefCfg = "process-unmapped-keys yes";
      config = ''
        (defsrc caps s d f g h j k l ; ' n m)
        (defvar tap-time 150 hold-time 200)
        (defalias
          caps esc
          a (tap-hold $tap-time $hold-time a lmet)
          s (tap-hold $tap-time $hold-time s lalt)
          d (tap-hold $tap-time $hold-time d lctl)
          f (tap-hold $tap-time $hold-time f lsft)
          g (tap-hold $tap-time $hold-time g lmet)
          h (tap-hold $tap-time $hold-time h lmet)
          j (tap-hold $tap-time $hold-time j lsft)
          k (tap-hold $tap-time $hold-time k lctl)
          l (tap-hold $tap-time $hold-time l lalt)
          ; (tap-hold $tap-time $hold-time ; lmet)
          ' (tap-hold $tap-time $hold-time ' C-S-u)
          n (tap-hold $tap-time $hold-time n (unicode ñ))
          m (tap-hold $tap-time $hold-time m (unicode Ñ))
        )
        (deflayer base @caps @s @d @f @g @h @j @k @l @; @' @n @m)
      '';
    };
  };

  # --- Build-specific ---
  system.stateVersion = "24.05";
  # system.copySystemConfiguration = true;

}
