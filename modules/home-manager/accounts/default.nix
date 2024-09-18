{ lib, ... }:
{
	options.accounts = {
		enable = lib.mkEnableOption "Enable accounts module";

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
