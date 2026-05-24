{ inputs, pkgs }:
inputs.wrappers.wrappers.git.wrap {
  inherit pkgs;

  settings =
    let
      format-helpers = {
        color = name: content: "%C(${name})${content}%Creset";

        newline = "%n";

        authorName = "%an";
        authorEmail = "%ae";
        authorDate = "%ah"; # [A]uthor [H]uman readable date

        committerName = "%cn";
        committerEmail = "%ce";
        committerDate = "%ch"; # [C]ommitter [H]uman readable date

        signer = "%GS";

        subject = "%s";
        body = "%b";

        refs = "%d";

        hashFull = "%H";
        hashShort = "%h";
      };
    in
    {
      include.path = "~/.config/git/config";

      branch.sort = "-committerdate";
      column.ui = "auto";
      commit.gpgSign = true;
      core.excludesfile = "~/.config/git/ignore";
      help.autocorrect = "prompt";
      init.defaultBranch = "main";
      merge.conflictstyle = "zdiff3";
      pull.rebase = true;
      tag.sort = "version:refname";

      # gpg.ssh.allowedSignersFile = "${../resources/signing.pub}";

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

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      rerere = {
        enabled = true;
        autoupdate = true;
      };

      user = {
        email = "rubcessis.unofficial@gmail.com";
        name = "Disguised Pigeon";
        # signingkey = "${../resources/signing.pub}";
      };

      alias = {
        ls =
          "log --graph --pretty=format:'"
          + builtins.concatStringsSep " - " (
            with format-helpers;
            [
              "${color "red" hashShort}${color "yellow" refs}"
              "${color "blue" authorName}"
              "${color "green" subject}'"
            ]
          );
        ll =
          "log --graph --pretty=format:'"
          + (
            with format-helpers;
            builtins.concatStringsSep newline [
              "${color "red" hashFull} ${color "yellow" refs} - ${color "blue" authorName}"
              (color "green" "Author email: ${authorEmail}")
              (color "green" "Author date: ${authorDate}")
              (color "green" "Committer: ${committerName}")
              (color "green" "Committer email: ${committerEmail}")
              (color "green" "Commit date: ${committerDate}")
              (color "green" "Signer: ${signer}")
              ""
              subject
              ""
              "${body}'"
            ]
          );
        pl = "pull";
        ps = "push";
        st = "status -s";
        sta = "stash";
        stp = "stash pop";
        d = "diff";
        ds = "diff --staged";
      };
    };
}
