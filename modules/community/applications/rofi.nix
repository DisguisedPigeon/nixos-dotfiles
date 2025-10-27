{
  flake.modules.homeManager.rofi =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.maple-mono.NF ];
      programs.rofi = {
        enable = true;
        cycle = true;
        location = "center";
        terminal = "\${pkgs.wezterm}/bin/wezterm";
        modes = [
          "run"
          "drun"
          "window"
          "ssh"
        ];
      };
    };
}
