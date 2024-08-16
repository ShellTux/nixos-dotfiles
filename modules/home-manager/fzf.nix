{ lib, config, ... }:
{
	options = {
		fzf.enable = lib.mkEnableOption "Enable fzf module";
	};

	config = lib.mkIf config.fzf.enable {
		programs.fzf = {
			enable = true;
		};

		home.shellAliases = {
			fzf = ''fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'';
		};
	};
}
