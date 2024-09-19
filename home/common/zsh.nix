{pkgs, ...}:
{
	home.packages = [
		pkgs.bat
	];
  programs.zsh = {
    shellAliases = {
			cat = "bat";
		};
	};
}
