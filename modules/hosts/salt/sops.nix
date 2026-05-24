{
  flake.aspects.salt-sops.nixos = {
    sops.secrets = {
      user-password.neededForUsers = true;

      github-PAT = { };
      home-pass = { };
      home-ssid = { };
    };
  };
}
