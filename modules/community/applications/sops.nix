{ inputs, ... }:
let
  flake-file.inputs.sops-nix.url = "github:Mic92/sops-nix";
  flake.modules.nixos.sops =
    { pkgs, ... }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];
      environment.systemPackages = with pkgs; [ sops ];
      sops = {
        defaultSopsFile = ../../../secrets/secrets.yaml;
        defaultSopsFormat = "yaml";
        age.keyFile = "/sops/age/keys.txt";

        secrets.hello = {};
      };
    };
in
{
  inherit flake flake-file;
}
