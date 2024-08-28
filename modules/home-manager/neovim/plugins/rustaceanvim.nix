{}:
{
	enable = true;

	settings.server = {
		default_settings.rust-analyzer = {
			installCargo = true;
			installRustc = true;
			cargo.allFeatures = true;
			check.command = "clippy";
			inlayHints.lifetimeElisionHints.enable = "always";
		};
		standalone = false;
	};
}
