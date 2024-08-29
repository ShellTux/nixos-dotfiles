{ lib, config, ... }:
{
	options.zellij = {
		enable = lib.mkEnableOption "Enable zellij module";

		enableBashIntegration = lib.mkOption {
			description = "Whether to enable bash integration.";
			type = lib.types.bool;
			default = false;
		};

		enableZshIntegration = lib.mkOption {
			description = "Whether to enable zsh integration.";
			type = lib.types.bool;
			default = false;
		};
	};

	config = {
		programs.zellij = lib.mkIf config.zellij.enable {
			enable = true;

			enableBashIntegration = config.zellij.enableBashIntegration;
			enableZshIntegration = config.zellij.enableZshIntegration;
		};
	};
}
