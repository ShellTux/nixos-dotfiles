{ lib, config, ... }:
{
	options.apps.cli.neomutt = {
		enable = lib.mkEnableOption "Enable neomutt module";

		enableMbsync = lib.mkOption {
			description = "Whether to enable mbsync.";
			type = lib.types.bool;
			default = true;
		};
	};

	config = lib.mkIf config.apps.cli.neomutt.enable {
		programs.neomutt = {
			enable = true;

			checkStatsInterval = 60;
			vimKeys = true;
			sidebar.enable = true;
		};

		services.mbsync.enable = lib.mkIf config.apps.cli.neomutt.enableMbsync true;
		programs.mbsync.enable = lib.mkIf config.apps.cli.neomutt.enableMbsync true;

		xdg = {
			desktopEntries.neomutt = {
				name = "Neomutt";
				genericName = "Email Client";
				comment = "Read and send emails";
				exec = "neomutt %U";
				icon = "mutt";
				terminal = true;
				categories = [
					"Network"
					"Email"
					"ConsoleOnly"
				];
				type = "Application";
				mimeType = ["x-scheme-handler/mailto"];
			};
			mimeApps.defaultApplications."x-scheme-handler/mailto" = "neomutt.desktop";
		};

		accounts.email.accounts.gmail-work = {
			neomutt.enable = true;
			mbsync = {
				enable = true;

				create = "maildir";
			};
		};
	};
}
