{

  flake.aspects.noctalia = {
    nixos = {
      programs.noctalia.enable = true;
    };
    homeManager = {
      programs.noctalia = {
        enable = true;
        settings = ../../../resources/config/noctalia/noctalia-config-no-extra-theming.toml;
      };

    };
  };
}
