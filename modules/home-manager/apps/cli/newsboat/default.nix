{ lib, config, pkgs, ... }:
let
	cfg = config.apps.cli.newsboat;
	macro = key: macroBrowser: ''macro ${key} set browser "${macroBrowser} %u" ; open-in-browser ; set browser "${config.programs.newsboat.browser} %u"'';
in 
{
	options.apps.cli.newsboat = {
		enable = lib.mkEnableOption "Enable newsboat module";

		downloadTimeout = lib.mkOption {
			description = "The number of seconds Newsboat shall wait when downloading a feed before giving up. This is an option to improve the success of downloads on slow and shaky connections such as via a TOR proxy.";
			type = lib.types.int;
			default = 5;
		};

		refreshOnStartup = lib.mkOption {
			description = "If set to yes, then all feeds will be reloaded when Newsboat starts up. This is equivalent to the -r commandline option. See also auto-reload to additionally reload the feeds continuously.";
			type = lib.types.bool;
			default = true;
		};

		colorscheme = lib.mkOption {
			description = "Pick one of the colorschemes provided by newsboat";
			type = lib.types.str;
			default = "gruvbox";
			example = "nord";
		};

		enableVimKeybindings = lib.mkOption {
			description = "Wether to enable vim like keybindings.";
			type = lib.types.bool;
			default = true;
		};

		feeds = {
			enableArchLinuxFeeds = lib.mkOption {
				description = "Wether to enable Arch Linux Rss Feeds.";
				type = lib.types.bool;
				default = true;
			};
		};
	};

	imports = [
		./urls.crypt.nix
	];

	config = {
		programs.newsboat = lib.mkIf cfg.enable {
			enable = true;

			autoReload = true;
			reloadTime = 15;

			extraConfig = lib.mkMerge [
				"download-timeout ${toString cfg.downloadTimeout}"
				(lib.mkIf cfg.refreshOnStartup "refresh-on-startup ${lib.hm.booleans.yesNo cfg.refreshOnStartup}")
				"include ${pkgs.newsboat}/share/doc/newsboat/contrib/colorschemes/${cfg.colorscheme}"
				(lib.mkIf cfg.enableVimKeybindings (lib.mkMerge [
					""
					"# Vim Keybindings"
					"bind-key j down"
					"bind-key k up"
					"bind-key l open"
					"bind-key h quit"
					"bind-key g home feedlist"
					"bind-key g home articlelist"
					"bind-key g home article"
					"bind-key G end feedlist"
					"bind-key G end articlelist"
					"bind-key G end article"
				]))
				(lib.mkMerge [
				 ""
				 "# Highlights"
				 ''highlight article "^(Feed|Link):.*$" color6 default bold''
				 ''highlight article "^(Title|Date|Author):.*$" color6 default bold''
				 ''highlight article "https?://[^ ]+" color10 default underline''
				 ''highlight article "\\[[0-9]+\\]" color10 default bold''
				 ''highlight article "\\[image\\ [0-9]+\\]" color10 default bold''
				 ''highlight feedlist "^─.*$" color6 color236 bold''
				])
				(lib.mkMerge [
				 ""
				 "# Macros"
				 (macro "m" "${pkgs.mpv}/bin/mpv")
				 (macro "i" "${pkgs.imv}/bin/imv")
				])
			];
		};
	};
}

# vim:foldmethod=marker
