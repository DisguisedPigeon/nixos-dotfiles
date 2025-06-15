{
  programs.git = {
    enable = true;
  };

  xdg.configFile.git = {
    enable = true;
    source = ./configs/git;
  };
}
