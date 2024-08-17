{ lib, config, ... }:
{
	options.sudo = {
		enable = lib.mkEnableOption "Enable sudo module";

		disableTimeout = lib.mkOption {
			description = "Whether to disable the sudo password prompt timeout.";
			type = lib.types.bool;
			default = false;
		};

		enableBellPrompt = lib.mkOption {
			description = "Whether to ring the terminal bell at the sudo prompt.";
			type = lib.types.bool;
			default = true;
		};

		enableInsults = lib.mkOption {
			description = "Whether to enable insults. (Easteregg of sudo).";
			type = lib.types.bool;
			default = true;
		};
	};

	config = lib.mkIf config.sudo.enable {
		security.sudo = {
			enable = true;

			extraConfig = lib.mkMerge [
				(lib.mkIf config.sudo.disableTimeout "Defaults passwd_timeout=0")
				(lib.mkIf config.sudo.enableBellPrompt ''Defaults passprompt="[sudo] password for %p: "'')
				(lib.mkIf config.sudo.enableInsults "Defaults insults")
			];
		};
	};
}
