{
  flake-file.inputs.nix-sweep.url = "github:jzbor/nix-sweep";
  perSystem =
    { inputs', ... }:
    let
      pkgs = inputs'.nixpkgs.legacyPackages;
    in
    {
      devShells.clean = inputs'.nix-sweep.devShells.default;
      packages.clean = inputs'.nix-sweep.packages.default;
      devShells.default = pkgs.mkShell {
        buildInputs = [
          # Nix stuff
          pkgs.statix
          pkgs.deadnix
          pkgs.nil
          pkgs.nixd
          pkgs.nixfmt-tree

          # Lua stuff
          pkgs.stylua
          pkgs.lua-language-server

          pkgs.treefmt
        ];
      };
    };
}
