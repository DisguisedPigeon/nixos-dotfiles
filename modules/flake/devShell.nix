{
  perSystem =
    { inputs', system, ... }:
    let
      pkgs = inputs'.nixpkgs.legacyPackages;
    in
    {
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
