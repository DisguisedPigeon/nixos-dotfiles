{inputs, ...}: {
  flake-file = {
    inputs = {
      flake-file.url = "github:vic/flake-file";
    };
    description = "DPigeon's NixOS Config";
  };
}
