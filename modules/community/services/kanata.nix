{
  flake.aspects.kanata.nixos = {
    services.kanata.enable = true;

    services.kanata.keyboards.default = {
      extraDefCfg = ''
        concurrent-tap-hold yes
        process-unmapped-keys yes
      '';
      config = ''
        (defsrc caps ')

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
          caps lctl
          ' (tap-hold $tap-time $hold-time ' C-S-u)
        )
        (deflayer base @caps @')
      '';
    };
  };
}
