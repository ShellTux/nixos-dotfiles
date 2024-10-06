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
					index-format = "%-20.20D %-17.17n %Z %s";
					timestamp-format = "2006-01-02 03:04 PM";

					mouse-enabled = true;
					sidebar-width = 25;
					spinner = "[ ⡿ ],[ ⣟ ],[ ⣯ ],[ ⣷ ],[ ⣾ ],[ ⣽ ],[ ⣻ ],[ ⢿ ]";
				};
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
