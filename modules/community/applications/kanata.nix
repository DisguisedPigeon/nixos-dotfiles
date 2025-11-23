let
  flake.modules.nixos.kanata = {
    services.kanata.enable = true;
    services.kanata.keyboards.default = {
      extraDefCfg = "process-unmapped-keys yes";
      config = ''
        (defsrc caps a s d f g h j k l ; ')
        (defvar tap-time 150 hold-time 200)
        (defalias
          caps esc
          a (tap-hold $tap-time $hold-time a lmet)
          s (tap-hold $tap-time $hold-time s lalt)
          d (tap-hold $tap-time $hold-time d lctl)
          f (tap-hold $tap-time $hold-time f lsft)
          g (tap-hold $tap-time $hold-time g lmet)
          h (tap-hold $tap-time $hold-time h rmet)
          j (tap-hold $tap-time $hold-time j rsft)
          k (tap-hold $tap-time $hold-time k rctl)
          l (tap-hold $tap-time $hold-time l ralt)
          ; (tap-hold $tap-time $hold-time ; rmet)
          ' (tap-hold $tap-time $hold-time ' C-S-u)
        )
        (deflayer base @caps @a @s @d @f @g @h @j @k @l @; @')
      '';
    };
  };
in
{
  inherit flake;
}
