{ lib, config, pkgs, ... }:
{
	options.apps.cli.aerc.enable = lib.mkEnableOption "Enable aerc module";

	imports = [
		./extraBinds.nix
		./colorschemes
	];

	config = lib.mkIf config.apps.cli.aerc.enable {
		programs.aerc = {
			enable = true;

			extraConfig = {
				general.unsafe-accounts-conf = true;
				viewer.pager = "${pkgs.less}/bin/less -R";
				filters = {
					"text/plain" = "${pkgs.aerc}/libexec/aerc/filters/colorize";
					"text/calendar" = "${pkgs.gawk}/bin/awk --file ${pkgs.aerc}/libexec/aerc/filters/calendar";
					# "text/html" = "${pkgs.aerc}/libexec/aerc/filters/html | ${pkgs.aerc}/libexec/aerc/filters/colorize"; # Requires w3m, dante
					"text/html" = "${pkgs.w3m}/bin/w3m -T text/html -cols $(tput cols) -dump -o display_image=false -o display_link_number=true";
					"text/*" = ''${pkgs.bat}/bin/bat --force-colorization --paging=never --file-name="$AERC_FILENAME "'';
					"message/delivery-status" = "${pkgs.aerc}/libexec/aerc/filters/colorize";
					"message/rfc822" = "${pkgs.aerc}/libexec/aerc/filters/colorize";
					"application/x-sh" = "${pkgs.bat}/bin/bat --force-colorization --paging=never --language sh";
					"application/pdf" = "${pkgs.zathura}/bin/zathura -";
					"audio/*" = "${pkgs.mpv}/bin/mpv -";
					"image/*" = "${pkgs.imv}/bin/imv -";
				};
				ui = {
					border-char-horizontal = "━";
					border-char-vertical   = "┃";
					index-format           = "%-20.20D %-17.17n %Z %s";
					mouse-enabled          = true;
					sidebar-width          = 25;
					spinner                = "[ ⡿ ],[ ⣟ ],[ ⣯ ],[ ⣷ ],[ ⣾ ],[ ⣽ ],[ ⣻ ],[ ⢿ ]";
					this-day-time-format   = ''"           15:04"'';
					this-year-time-format  = "Mon Jan 02 15:04";
					timestamp-format       = "2006-01-02 15:04";
				};
				triggers.email-received = ''exec notify-send "New email from %n" "%s"'';
			};
		};

		accounts.email.accounts = let
			defaultAercConfig = {
				aerc = {
					enable = true;

					extraAccounts = {
						check-mail = "5m";
						check-mail-cmd = "${pkgs.isync}/bin/mbsync --all";
						check-mail-timeout = "15s";
					};
				};
			};
		in lib.mkIf config.accounts.email.enable {
			gmail-work = defaultAercConfig;
			dei = defaultAercConfig;
		};

	};
}
