{
  flake.aspects.nixos.nixos =
    { lib, ... }:
    {
      environment.sessionVariables = rec {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_STATE_HOME = "$HOME/.local/state";
        XDG_BIN_HOME = "$HOME/.local/bin";

        # Not officially in the specification
        PATH = [ "${XDG_BIN_HOME}" ];
      };
      users.mutableUsers = lib.mkDefault false;
      programs.neovim = {
        enable = true;
        defaultEditor = true;
      };
    };
}
