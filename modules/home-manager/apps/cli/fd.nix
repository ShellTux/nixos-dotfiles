{ lib, config, ... }:
{
	options.apps.cli.fd = {
		enable = lib.mkEnableOption "Enable fd module";

		extraIgnores = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			default = [];
			description = "List of extra paths that should be globally ignored.";
		};
	};

	config = lib.mkIf config.apps.cli.fd.enable {
		programs.fd = {
			enable = true;

			ignores = [
				".git/"
				"*.bak"
			] ++ config.apps.cli.fd.extraIgnores;
		};
	};
}
