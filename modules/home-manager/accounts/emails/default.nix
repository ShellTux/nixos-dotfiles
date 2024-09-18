{ config, lib, ... }:
{
	imports = [ ./emails.crypt.nix ];
	accounts.email = lib.mkIf config.accounts.email.enable {
		maildirBasePath = "Mail";
		accounts = {
			gmail-work = {
				primary = true;
				flavor = "gmail.com";
			};
		};
	};
}
