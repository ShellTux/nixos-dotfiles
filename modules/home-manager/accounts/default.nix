{ lib, ... }:
{
	options.accounts = {
		enable = lib.mkEnableOption "Enable accounts module";

		calendar.enable = lib.mkOption {
			description = "Whether to enable calendar";
			type = lib.types.bool;
			default = true;
		};

		# FIX: failed assertion: profile must have exactly one primary mail when this option is false
		email.enable = lib.mkOption {
			description = "Whether to enable email";
			type = lib.types.bool;
			default = true;
		};
	};

	imports = [
		./calendar
		./emails
	];
}
