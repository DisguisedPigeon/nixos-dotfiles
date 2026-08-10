{
  flake.aspects.ssh-client.nixos = {
    programs.ssh.startAgent = true;
  };
}
