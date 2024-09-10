{ lib, config, pkgs, ... }:
{
	options.slack.enable = lib.mkEnableOption "Enable slack module";

	config = lib.mkIf config.slack.enable {
		home.packages = with pkgs; [
			slack
		];
	};
}
