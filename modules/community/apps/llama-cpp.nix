{
  flake.aspects.llama-cpp.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ llama-cpp ];
    };
}
