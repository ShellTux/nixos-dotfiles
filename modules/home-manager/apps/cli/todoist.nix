{ lib, config, pkgs, ... }:
{
	options.apps.cli.todoist.enable = lib.mkEnableOption "Enable todoist module";

	config = lib.mkIf config.apps.cli.todoist.enable {
		home.packages = with pkgs; [
			todoist
		];
	};
}
