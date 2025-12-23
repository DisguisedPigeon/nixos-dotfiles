{ inputs, ... }:
let
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.sops =
    { pkgs, ... }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      environment.systemPackages = with pkgs; [ sops ];

      sops = {
        defaultSopsFile = ../../../secrets/secrets.yaml;
        defaultSopsFormat = "yaml";
        age.keyFile = "/sops/age/keys.txt";

        secrets = {
          user-password.neededForUsers = true;
          net-secretsFile = { };
          github-PAT = { };
        };
      };
    };

  flake.modules.homeManager.sops =
    {
      pkgs,
      config,
      ...
    }:
    {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];

      home.packages = with pkgs; [ sops ];

      sops = {
        defaultSopsFile = ../../../secrets/secrets.yaml;
        defaultSopsFormat = "yaml";
        age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        secrets = {
          bitwarden-mail = { };
        };
      };
    };
in
{
  inherit flake flake-file;
}
