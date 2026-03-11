{
  flake.aspects.locale.nixos =
    { lib, ... }:
    {
      time.timeZone = lib.mkDefault "Europe/Madrid";
      i18n = {
        defaultLocale = lib.mkDefault "gl_ES.UTF-8";
        extraLocales = lib.mkDefault [
          "es_ES.UTF-8/UTF-8"
          "en_US.UTF-8/UTF-8"
        ];
      };
    };
}
