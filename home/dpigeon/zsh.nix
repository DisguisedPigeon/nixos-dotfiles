{ config, pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
    shellAliases = {
      hupdate = "home-manager --flake .#dpigeon@DPigeon-MacOS switch";
      nupdate = "sudo nixos-rebuild --flake .#DPigeon-MacOS switch";
      fupdate = "sudo nixos-rebuild --flake --upgrade-all .#DPigeon-MacOS switch";
      ":q" = "exit";
      ll = "ls -lah";
      ga = "git add .";
      gc = "git commit";
      gl = "git log --graph --pretty=format:'%Cred%h%C(yellow)%d%Creset - %Cblue%an%Creset - %Cgreen%s'";
      gll = "git log --graph --pretty=format:'%Cred%H%C(yellow)%d%Creset - %Cblue%an%n%CgreenAuthor email: %ae%n%CgreenAuthor date: %ah%n%CgreenCommitter: %cn%n%CgreenCommitter email: %ce%n%CgreenCommit date: %ch%n%CgreenSigner: %GS%n%n%s%n%n%b'";
      gpl = "git pull";
      gps = "git push";
      gs = "git status";
      gst = "git stash";
      gsp = "git stash pop";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
