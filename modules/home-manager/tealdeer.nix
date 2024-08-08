{ pkgs, lib, config, inputs, ... }:
{
	options = {
		tealdeer.enable = lib.mkEnableOption "Enable tealdeer module";
	};

	config = lib.mkIf config.tealdeer.enable {
		programs.tealdeer = {
			enable = true;

			settings = {
				display = {
					compact = false;
					use_pager = false;
				};
				updates = {
					auto_update = true;
					auto_update_interval_hours = 720;
				};
			};
		};
	};
}
