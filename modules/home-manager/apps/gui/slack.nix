{ lib, config, pkgs, ... }:
{
	options.apps.gui.slack.enable = lib.mkEnableOption "Enable slack module";

	config = lib.mkIf config.apps.gui.slack.enable {
		home.packages = with pkgs; [
			slack
		];
	};
}
