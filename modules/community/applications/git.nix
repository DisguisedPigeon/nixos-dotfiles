{
  flake.modules.nixos.git = {
    programs.git = {
      enable = true;
      config = {
        gpg.format = "ssh";
      };
    };
  };

  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          email = "rubcessis.unofficial@gmail.com";
          name = "Disguised Pigeon";
          signingkey = "/home/dpigeon/.ssh/signing_ed25519.pub";
        };
        maintenance.repo = "/home/.nixos-config";

        aliases = {
          ls = "log --graph --pretty=format:'%Cred%h%C(yellow)%d%Creset - %Cblue%an%Creset - %Cgreen%s'";
          ll = "log --graph --pretty=format:'%Cred%H%C(yellow)%d%Creset - %Cblue%an%n%CgreenAuthor email: %ae%n%CgreenAuthor date: %ah%n%CgreenCommitter: %cn%n%CgreenCommitter email: %ce%n%CgreenCommit date: %ch%n%CgreenSigner: %GS%n%n%s%n%n%b'";
          pl = "pull";
          ps = "push";
          st = "status -s";
          sta = "stash";
          stp = "stash pop";
          d = "diff";
          ds = "diff --staged";
        };

        column.ui = "auto";

        branch.sort = "-committerdate";

        tag.sort = "version:refname";

        init.defaultBranch = "main";

        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicPrefix = true;
          renames = true;
        };

        push = {
          default = "simple";
          autoSetupRemote = true;
          followTags = true;
        };

        help.autocorrect = "prompt";

        rerere = {
          enabled = true;
          autoupdate = true;
        };

        core.excludesfile = "~/.config/git/ignore";

        rebase = {
          autoSquash = true;
          autoStash = true;
          updateRefs = true;
        };

        merge.conflictstyle = "zdiff3";

        pull.rebase = true;
      };
    };
  };
}
