# Generally useful nix settings

{
  lib,
  outputs,
  config,
  inputs,
  ...
}:
{
  nixpkgs = {
    overlays = [ outputs.overlays.nvim-nightly ];
    config.allowUnfree = true;
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
      };

      optimise.automatic = true;

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 10d";
      };

      channel.enable = false;

      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };
}
