{ pkgs, lib, config, inputs, ... }:
{
	options = {
		eza.enable = lib.mkEnableOption "Enable eza module";
	};

	config = lib.mkIf config.eza.enable {
		programs.eza = {
			enable = true;

			git = true;
			icons = true;
			extraOptions = [
				"--across"
				"--color=automatic"
				"--color-scale=all"
				"--group-directories-first"
				"--binary"
				"--group"
				"--header"
			];
		};

		home.shellAliases = {
			tree = "eza --color=auto --color-scale all --icons --tree --git-ignore";
		};
	};
}
