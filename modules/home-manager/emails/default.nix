{ ... }:
{
	imports = [ ./emails.crypt.nix ];
	accounts.email = {
		maildirBasePath = "Mail";
		accounts = {
			gmail-work = {
				primary = true;
				flavor = "gmail.com";
			};
		};
	};
}
