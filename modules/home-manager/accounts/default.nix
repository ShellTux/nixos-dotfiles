{ lib, ... }:
{
	options.accounts = {
		enable = lib.mkEnableOption "Enable accounts module";

		# FIX: failed assertion: profile must have exactly one primary mail when this option is false
		email.enable = lib.mkOption {
			description = "Whether to enable email";
			type = lib.types.bool;
			default = true;
		};
	};

	imports = [
		./emails
	];
}
