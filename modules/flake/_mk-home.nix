{ inputs, pkgs, ... }:
name:
inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = [
    inputs.self.modules.homeManager.${name}
    (
      let
        uname = builtins.elemAt (builtins.splitString "-" name) 0;
      in
      {
        home.username = uname;
        home.homeDirectory = "/home/${uname}";
        home.stateVersion = "25.05";
      }
    )
  ];
}
