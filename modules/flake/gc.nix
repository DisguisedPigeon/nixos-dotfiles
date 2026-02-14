{
  flake-file.inputs = {
    nix-sweep.url = "github:jzbor/nix-sweep";
    nix-sweep.inputs.nixpkgs.follows = "nixpkgs";
  };

  perSystem =
    { inputs', ... }:
    {
      devShells.clean = inputs'.nix-sweep.devShells.default;
    };
}
