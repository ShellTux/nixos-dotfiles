{ config, pkgs, ... }:
let
	keybinds = {
		control = key: "\\C${key}";
	};

	command = {
		shell = {
			silent = command: "<enter-command>unset wait_key<enter><shell-escape>${command}<enter><enter-command>set wait_key<enter>";
			wait = command:  "<enter-command>set wait_key<enter><shell-escape>${command}<enter><enter-command>unset wait_key<enter>";
			normal = command:  "<shell-escape>${command}<enter>";
		};
		pipe = {
			message = command: "<pipe-message>${command}<enter>";
			entry  = command: "<pipe-entry>${command}<enter>";
		};
	};

	mbsync = "${config.programs.mbsync.package}/bin/mbsync";
	urlscan = "${pkgs.urlscan}/bin/urlscan";
in 
{
	programs.neomutt.macros = [
	{
		key = keybinds.control "r";
		map = [ "index" ];
		action = command.shell.silent "${mbsync} --all";
	}
	{
		key = "F";
		map = [ "index" "pager" ];
		action = command.pipe.message urlscan;
	}
	{
		key = "A";
		map = [ "index" "pager" ];
		action = command.pipe.message "${pkgs.abook}/bin/abook --add-email";
	}
	];
}
