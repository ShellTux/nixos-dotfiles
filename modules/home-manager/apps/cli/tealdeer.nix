{ lib, config, ... }:
{
	options.apps.cli.tealdeer.enable = lib.mkEnableOption "Enable tealdeer module";

	config = lib.mkIf config.apps.cli.tealdeer.enable {
		programs.tealdeer = {
			enable = true;

			settings = {
				display = {
					compact = false;
					use_pager = true;
				};
				updates = {
					auto_update = true;
					auto_update_interval_hours = 720;
				};
			};
		};

		home.shellAliases = {
			tldr = "PAGER='less --RAW-CONTROL-CHARS --quit-if-one-screen' tldr";
		};
	};
}
