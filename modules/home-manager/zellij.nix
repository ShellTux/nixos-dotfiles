{ lib, config, ... }:
{
	options.zellij.enable = lib.mkEnableOption "Enable zellij module";

	config = {
		programs.zellij = lib.mkIf config.zellij.enable {
			enable = true;

			enableBashIntegration = true;
			enableZshIntegration = true;

			settings = {

			};
		};
	};
}
