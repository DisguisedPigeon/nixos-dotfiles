{ inputs, ... }:
{
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.sops = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.sops-nix.nixosModules.sops ];

        sops.secrets = {
          user-password.neededForUsers = true;
          github-PAT = { };
          home-pass = { };
          home-ssid = { };
        };

        environment.systemPackages = [ pkgs.sops ];
        sops = {
          defaultSopsFile = ../../../secrets/secrets.yaml;
          defaultSopsFormat = "yaml";
          age.keyFile = "/sops/age/keys.txt";
        };
      };

    homeManager =
      { config, ... }:
      {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];

        sops.secrets = {
          bitwarden-mail = { };
        };

        sops = {
          defaultSopsFile = ../../../secrets/secrets.yaml;
          defaultSopsFormat = "yaml";
          age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        };
      };
  };
}
