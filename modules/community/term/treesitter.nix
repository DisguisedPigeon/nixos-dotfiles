{
  flake.aspects.treesitter.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.tree-sitter ];
    };
}
