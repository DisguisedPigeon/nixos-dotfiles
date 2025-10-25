{
  flake.modules.nixos.locale = {
    time.timeZone = "Europe/Madrid";
    i18n = {
      defaultLocale = "gl_ES.UTF-8";
      extraLocales = [
        "es_ES.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
      ];
    };
  };
}
