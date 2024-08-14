{ pkgs }:
{
	format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ({songPosition}|{queueLength}) {volume}% ";
	format-disconnected = "Disconnected ";
	format-paused = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Paused ";
	format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
	unknown-tag = "N/A";
	interval = 2;
	max-length = 70;
	on-click = "notify-music";
	on-click-right = "${pkgs.mpc-cli}/bin/mpc toggle";
	on-scroll-up = "${pkgs.mpc-cli}/bin/mpc volume +5";
	on-scroll-down = "${pkgs.mpc-cli}/bin/mpc volume -5";
	consume-icons = {
		on = " ";
	};
	random-icons = {
		off = "<span color=\"#f53c3c\"></span> ";
		on = " ";
	};
	repeat-icons = {
		on = " ";
	};
	single-icons = {
		on = "1 ";
	};
	state-icons = {
		paused = "";
		playing = "";
	};
	tooltip-format = "MPD (connected)";
	tooltip-format-disconnected = "MPD (disconnected)";
}
