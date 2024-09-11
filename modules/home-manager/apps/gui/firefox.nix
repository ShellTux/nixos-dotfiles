{ pkgs, lib, config, inputs, username, ... }:
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
	options.apps.gui.firefox = {
		enable = lib.mkEnableOption "Enable firefox module";

		enableFf2mpv = lib.mkOption {
			description = "Wether to enable the ff2mpv extension.";
			type = lib.types.bool;
			default = true;
		};
	};

	config = lib.mkIf config.apps.gui.firefox.enable {
		programs.firefox = {
			enable = true;

			package = (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {});

			languagePacks = [
				"pt-PT"
				"en-US"
			];

			nativeMessagingHosts = with pkgs; [
				(lib.mkIf config.apps.gui.firefox.enableFf2mpv ff2mpv)
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
					(lib.mkIf config.apps.gui.firefox.enableFf2mpv ff2mpv)
					return-youtube-dislikes
					search-by-image
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

		xdg = {
			portal = {
				enable = true;
				extraPortals = with pkgs; [
					xdg-desktop-portal-wlr
					xdg-desktop-portal-gtk
				];
			};
			mimeApps.defaultApplications = {
				"application/x-extension-htm" = "firefox.desktop";
				"application/x-extension-html" = "firefox.desktop";
				"application/x-extension-shtml" = "firefox.desktop";
				"application/x-extension-xht" = "firefox.desktop";
				"application/x-extension-xhtml" = "firefox.desktop";
				"application/xhtml+xml" = "firefox.desktop";
				"text/html" = "firefox.desktop";
				"x-scheme-handler/chrome" = "firefox.desktop";
				"x-scheme-handler/http" = "firefox.desktop";
				"x-scheme-handler/https" = "firefox.desktop";
			};
		};
	};
}
