{ inputs, ... }:
{
  imports = [ inputs.flake-file.flakeModules.dendritic ];
  flake-file.inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
}
