{
  perSystem =
    { inputs', ... }:
    {
      packages.default = inputs'.nixpkgs.legacyPackages.asciidoctor;
      packages.zathura = inputs'.nixpkgs.legacyPackages.zathura;
      packages.typora = inputs'.nixpkgs.legacyPackages.typora;
    };
}
