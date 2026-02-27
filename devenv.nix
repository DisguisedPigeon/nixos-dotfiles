{ ... }:

{
  languages.nix.enable = true;

  enterTest = ''
    echo "Running tests"
    nix flake check
  '';
}
