{
  flake.aspects.pepper-sops.nixos = {
    sops.secrets = {
      user-password.neededForUsers = true;
      github-PAT = { };
      home-pass = { };
      home-ssid = { };
      pepper-nextcloud = { };
      pepper-dpigeon-nextcloud = { };
    };
  };
}
