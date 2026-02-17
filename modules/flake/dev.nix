{
  perSystem =
    { inputs', ... }:
    let
      pkgs = inputs'.nixpkgs.legacyPackages;
    in
    {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # Nix tools
          statix
          deadnix
          nil
          nixfmt-tree
          nixf-diagnose

          # Lua tools
          stylua
          lua-language-server
          lua53Packages.luacheck

          # General
          treefmt
          prettier
          taplo
        ];
      };
    };
}
