{
  flake.aspects.rofi.homeManager =
    { pkgs, ... }:
    {
      programs.rofi.enable = true;
      home.packages = with pkgs; [ maple-mono.NF ];

      programs.rofi = {
        cycle = true;
        location = "center";
        terminal = "${pkgs.wezterm}/bin/wezterm";
        modes = [
          "run"
          "drun"
          "window"
          "ssh"
        ];
      };
    };
}
