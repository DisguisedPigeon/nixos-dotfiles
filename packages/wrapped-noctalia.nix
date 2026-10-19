inputs: { pkgs, lib, ... }: {
  home.shellAliases =
    let
      curlwrapped = inputs.wrappers.lib.wrapPackage (
        { ... }: {
          inherit pkgs; # you can only grab the final package if you supply pkgs!
          package = pkgs.noctalia;
          flags = {
            "--target" = "";
          };
          flagSeparator = "="; # Use --flag=value instead of --flag value (default is " ")
          runShell = [
            ''
              echo "Making request..." >&2
            ''
          ];
        }
      );
    in
    {
      runCurl = "${lib.getExe curlwrapped}";
    };
}
