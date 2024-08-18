{ pkgs, lib, config, ... }:
{
	options = {
		bat.enable = lib.mkEnableOption "Enable bat module";
	};

	config = lib.mkIf config.bat.enable {
		programs.bat = {
			enable = true;

			config = {
				pager = "less --RAW-CONTROL-CHARS";
				theme = "TwoDark";
				map-syntax = [
					"*.ino:C++"
					".ignore:Git Ignore"
					"aliasrc:Bourne Again Shell (bash)"
					"bash_profile:Bourne Again Shell (bash)"
					"bashrc:Bourne Again Shell (bash)"
					"*.conf:INI"
					"dunstrc:INI"
				];
			};

			extraPackages = with pkgs.bat-extras; [
				batdiff
				batgrep
				batman
				batpipe
				batwatch
			];
		};

		home.shellAliases = {
			bathelp = "bat --plain --language=help";
			man = "batman";
		};
	};
}
