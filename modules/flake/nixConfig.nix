{
  flake-file = {
    description = "DPigeon's NixOS Config";
    inputs.flake-file.url = "github:vic/flake-file";
    nixConfig.allow-import-from-derivation = true;
  };

}
