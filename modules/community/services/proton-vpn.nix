{
  flake.aspects.proton-vpn.nixos = { pkgs, ... }: {
    networking.firewall.checkReversePath = false;
    environment.systemPackages = with pkgs; [
      wireguard-tools
      proton-vpn
    ];
  };
}
