{ lib, config, pkgs, ... }:
let
	historySize = 999999999;
in
{
	options = {
		zsh.enable = lib.mkEnableOption "Enable zsh module";
	};

	config = lib.mkIf config.zsh.enable {
		programs.zsh = {
			enable = true;

			enableBashCompletion = true;
			enableCompletion = true;
			histSize = historySize;
			interactiveShellInit = lib.mkMerge [
				"${pkgs.fastfetch}/bin/fastfetch"
			];
			syntaxHighlighting = {
				enable = true;
				highlighters = [
					"main"
					"brackets"
					"pattern"
					"regexp"
				];
				patterns = {
					"rm -rf *" = "fg=white,bold,bg=red";
				};
				styles = {
					alias = "fg=magenta,bold";
					comment = "fg=black,bold";
				};
			};
		};
	};
}
