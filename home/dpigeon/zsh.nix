{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      nupdate = "sudo nixos-rebuild --flake .#DPigeon-MacOS switch";
      ll = "ls -lah";
      ga = "git add .";
      gc = "git commit";
      gl = "git log --graph --pretty=format:'%Cred%h%C(yellow)%d%Creset - %Cblue%an%Creset - %Cgreen%s'";
      gll = "git log --graph --pretty=format:'%Cred%H%C(yellow)%d%Creset - %Cblue%an%n%CgreenAuthor email: %ae%n%CgreenAuthor date: %ah%n%CgreenCommitter: %cn%n%CgreenCommitter email: %ce%n%CgreenCommit date: %ch%n%CgreenSigner: %GS%n%n%s%n%n%b'";
      gpl = "git pull";
      gps = "git push";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
