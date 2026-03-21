{
  flake-file.inputs = {
    nix-sweep.url = "github:jzbor/nix-sweep";
  };

  perSystem =
    { inputs', ... }:
    {
      devShells.clean = inputs'.nix-sweep.devShells.default;
    };
}
