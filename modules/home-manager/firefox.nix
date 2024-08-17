{ lib, config, inputs, username, ... }:
let
	lock-false = {
		Value = false;
		Status = "locked";
	};
	lock-true = {
		Value = true;
		Status = "locked";
	};
	lock-empty-string = {
		Value = "";
		Status = "locked";
	};
in
{
	options = {
		firefox.enable = lib.mkEnableOption "Enable firefox module";
	};

	config = lib.mkIf config.firefox.enable {
		programs.firefox = {
			enable = true;

			languagePacks = [
				"pt-PT"
				"en-US"
			];

			policies = {
				DisableAccounts = true;
				DisableFirefoxAccounts = true;
				DisableFirefoxStudies = true;
				DisablePocket = true;
				DisableTelemetry = true;
				DisplayBookmarksToolbar = "always"; # never, always, newtab
				DisplayMenuBar = "default-off"; # default-off, "always", "never", "default-on"
				DontCheckDefaultBrowser = true;
				SearchBar = "unified"; # unified, separate

				Preferences = {
					"extensions.pocket.enabled" = lock-false;
					"browser.newtabpage.pinned" = lock-empty-string;
					"browser.topsites.contile.enabled" = lock-false;
					"browser.newtabpage.activity-stream.showSponsored" = lock-false;
					"browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
					"browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
				};
			};

			profiles.${username} = {
				extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
					bitwarden
					darkreader
					return-youtube-dislikes
					sponsorblock
					tridactyl
					ublock-origin
					xbrowsersync
				];

				settings = {
					"browser.search.defaultenginename" = "DuckDuckGo";
					"browser.search.order.1" = "DuckDuckGo";

					"signon.rememberSignons" = false;
					"widget.use-xdg-desktop-portal.file-picker" = 1;

					#"mousewheel.default.delta_multiplier_x" = 20;
					#"mousewheel.default.delta_multiplier_y" = 20;
					#"mousewheel.default.delta_multiplier_z" = 20;

					# Firefox 75+ remembers the last workspace it was opened on as part of its session management.
					# This is annoying, because I can have a blank workspace, click Firefox from the launcher, and
					# then have Firefox open on some other workspace.
					"widget.disable-workspace-management" = true;
				};

				search = {
					force = true;
					default = "DuckDuckGo";
					order = [ "DuckDuckGo" "Google" ];
				};
			};
		};
	};
}
