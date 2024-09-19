{pkgs, ...}:
{
	home.packages = with pkgs; [
		bat
		eza
		zoxide
		fzf	
	];
  programs.zsh = {
    shellAliases = {
			cat = "bat";
			ls = "eza";
			cd = "z";
		};
	};
}
