{
  flake.modules.nixos.kanata = {
    services.kanata.enable = true;

    services.kanata.keyboards.default = {
      extraDefCfg = ''
        concurrent-tap-hold yes
        process-unmapped-keys yes
      '';
      config = ''
        (defsrc caps a s d f g h j k l ; ')

        (defvar tap-time 150 hold-time 200)

        ;;(defchordsv2
        ;;  (lalt u) t $hold-time all-released ()
        ;;  (lalt i) y $hold-time all-released ()
        ;;  (lalt p) o $hold-time all-released ()
        ;;  (lalt 8) 7 $hold-time all-released ()
        ;;  (lalt lshift u) S-t $hold-time all-released ()
        ;;  (lalt lshift i) S-y $hold-time all-released ()
        ;;  (lalt lshift p) S-o $hold-time all-released ()
        ;;  (lalt lshift 8) S-7 $hold-time all-released ()
        ;;  (lalt rshift u) S-t $hold-time all-released ()
        ;;  (lalt rshift i) S-y $hold-time all-released ()
        ;;  (lalt rshift p) S-o $hold-time all-released ()
        ;;  (lalt rshift 8) S-7 $hold-time all-released ()
        ;;)

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
}
