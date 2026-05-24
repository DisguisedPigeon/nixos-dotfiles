{ inputs, pkgs }:
inputs.wrappers.wrappers.jujutsu.wrap {
  inherit pkgs;
  settings = {
    user = {
      email = "rubcessis.unofficial@gmail.com";
      name = "Disguised Pigeon";
    };

    signing = {
      behaviour = "own";
      backend = "ssh";
      signingkey = "${../resources/signing.pub}";
      backends.ssh.allowed-signers = "${../resources/signing.pub}";
    };

    # git.sign-on-push = true;

    ui = {
      default-command = "st";
      editor = "nvim";
      diff-editor = "nvim -d";
      pager = "less -FRX";
      show-cryptographic-signatures = true;
    };

    template-aliases."format_short_signature(signature)" = "signature";
  };
}
