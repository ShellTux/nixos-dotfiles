{ lib, config, ... }:
{
	options.apps.cli.khal.enable = lib.mkEnableOption "Enable khal module";

	config = lib.mkIf config.apps.cli.khal.enable {
		programs.khal = {
			enable = true;
			settings = {
				default = {
					default_event_duration = "30m";
					highlight_event_days = true;
					timedelta = "5d";
				};

				view = {
					frame = "color";
					theme = "dark";
					event_view_always_visible = true;
					dynamic_days = false;
					min_calendar_display = 2;
				};
			};
		};

		accounts.calendar.accounts = let
			khal.colors = {
				black = "black";
				white = "white";
				brown = "brown";
				yellow = "yellow";
				dark-gray = "dark gray";
				dark-green = "dark green";
				dark-blue = "dark blue";
				light-gray = "light gray";
				light-green = "light green";
				light-blue = "light blue";
				dark-magenta = "dark magenta";
				dark-cyan = "dark cyan";
				dark-red = "dark red";
				light-magenta = "light magenta";
				light-cyan = "light cyan";
				light-red = "light red";
			};
		in 
		{
			work.khal = {
				enable = true;
				color = khal.colors.light-cyan;
			};
			personal.khal = {
				enable = true;
				color = khal.colors.light-green;
			};
		};
	};
}
