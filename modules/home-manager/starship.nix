{ pkgs, lib, config, inputs, ... }:
{
	options = {
		starship = {
			enable = lib.mkEnableOption "Enable starship module";
			enableBashIntegration = lib.mkEnableOption "Bash Integration" // {
				default = true;
			};
			enableZshIntegration = lib.mkEnableOption "Bash Integration" // {
				default = false;
			};
		};
	};

	config = lib.mkIf config.starship.enable {
		programs.starship = {
			enable = true;

			enableBashIntegration = config.starship.enableBashIntegration;
			enableZshIntegration = config.starship.enableZshIntegration;
			settings = {
				add_newline = true;
				scan_timeout = 10;
				character.success_symbol = "[➜](bold green)";
				package.disabled = false;
			};
		};
	};
}
