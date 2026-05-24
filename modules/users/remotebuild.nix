{
  flake.aspects.remotebuild.nixos = {
    nix.sshServe = {
      enable = true;
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE+GPT8+aH7YzqgtuXA+hvbDyqprRuj74/FNNkcmFNBg root@salt"
      ];
    };
  };
}
