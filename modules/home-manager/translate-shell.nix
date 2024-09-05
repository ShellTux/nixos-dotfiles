{ lib, config, ... }:
{
	options.translate-shell.enable = lib.mkEnableOption "Enable translate-shell module";

	config = lib.mkIf config.translate-shell.enable {
		programs.translate-shell.enable = true;
	};
}
