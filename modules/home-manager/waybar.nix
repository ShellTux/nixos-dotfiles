{ pkgs, lib, config, ... }:
let
	height = 30;
	spacing = 4;
	output = [
		"eDP-1"
		"HDMI-A-1"
	];


	backlight = {
		format = "{percent}% {icon}";
		format-icons = [
			""
			""
			""
			""
			""
			""
			""
			""
			""
		];
		on-scroll-up = "brightnessctl set +1% --quiet";
		on-scroll-down = "brightnessctl set 1%- --min-value 1 --quiet";
	};

	battery = {
		states = {
			good = 95;
			warning = 30;
			critical = 15;
		};
		format = "{capacity}% {icon}";
		format-charging = "{capacity}% ";
		format-plugged = "{capacity}% ";
		format-alt = "{time} {icon}";
		format-icons = [
			""
			""
			""
			""
			""
		];
	};

	clock = {
		tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
		format = "{:%H:%M} ";
		format-alt = "{:%I:%M %p} ";
		calendar = {
			mode = "month";
			mode-mon-col = 3;
			weeks-pos = "right";
			on-scroll = 1;
			on-click-right = "mode";
			format = {
				months = "<span color='#ffead3'><b>{}</b></span>";
				days = "<span color='#ecc6d9'><b>{}</b></span>";
				weeks = "<span color='#99ffdd'><b>W{}</b></span>";
				weekdays = "<span color='#ffcc66'><b>{}</b></span>";
				today = "<span color='#ff6699'><b><u>{}</u></b></span>";
			};
		};
	};

	clock-date = {
		format = "{:%d/%m} ";
		format-alt = "{:%a, %d/%m/%y} ";
		tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
		calendar = {
			mode = "year";
			mode-mon-col = 3;
			format = {
				months = "<span color='#ffead3'><b>{}</b></span>";
				days = "<span color='#ecc6d9'><b>{}</b></span>";
				weeks = "<span color='#99ffdd'><b>W{}</b></span>";
				weekdays = "<span color='#ffcc66'><b>{}</b></span>";
				today = "<span color='#ff6699'><b><u>{}</u></b></span>";
			};
		};
	};

	cpu = {
		format = "{icon} {usage}% ";
		tooltip = false;
		interval = 3;
		format-icons = [
			"▁"
			"▂"
			"▃"
			"▄"
			"▅"
			"▆"
			"▇"
			"█"
		];
		states.critical = 90;
	};

	custom = {
		kernel = {
			exec = "uname --kernel-release";
			format = " {}";
			interval = "once";
			exec-if = "exit 0";
			signal = 9;
		};

		power = {
			format = "";
			tooltip = false;
			on-click = "sh -c '(sleep 0.3s; wlogout --protocol layer-shell)' & disown";
		};

		weather = {
			format = "{}";
			tooltip = true;
			interval = 3600;
			exec = "waybar-wttr.py";
			return-type = "json";
		};

		network-traffic = {
			format = "{icon} {}";
			return-type = "json";
			interval = "1";
		};
	};

	disk = {
		interval = 30;
		format = " {path}: {percentage_used}%";
		path = "/";
	};

	disk-home = {
		interval = 30;
		format = " {path}: {percentage_used}%";
		path = "/home";
	};

	hyprland = {
		window = {
			format = "{title}";
			rewrite = {
				"(.*) — Mozilla Firefox" = "$1";
				"( )?(.*) - n?vim" = "$2  $1";
				"^n?vim$" = "";
			};
			separate-outputs = true;
			max-length = 50;
			icon = true;
		};

		language = {
			format = " {}";
			format-en = "EN";
			format-pt = "PT";
		};

		workspaces = {
			disable-scroll = true;
			all-outputs = true;
			active-only = false;
			format = "{name}: {icon}";
			format-icons = {
				"1" = "";
				"2" = "";
				"3" = "";
				"4" = "";
				"5" = "E";
				"6" = "";
				"7" = "";
				"8" = "";
				"9" = "";
				"urgent" = "";
				"focused" = "";
				"default" = "";
			};
			on-click = "activate";
			on-scroll-up = "hyprctl dispatch workspace e-1";
			on-scroll-down = "hyprctl dispatch workspace e+1";
		};

		submap = {
			format = "✌️ {}";
			max-length = 8;
			tooltip = false;
		};
	};

	idle_inhibitor = {
		format = "{icon}";
		format-icons = {
			activated = "";
			deactivated = "";
		};
	};

	keyboard-state = {
		numlock = true;
		capslock = true;
		format = {
			numlock = "N {icon}";
			capslock = "C {icon}";
		};
		format-icons = {
			locked = "";
			unlocked = "";
		};
	};

	memory = {
		format = "{}% ";
		format-alt = "{used:0.1f} GiB / {total} GiB ";
		states = {
			warning = 80;
			critical = 90;
		};
	};

	mpd = {
		format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ({songPosition}|{queueLength}) {volume}% ";
		format-disconnected = "Disconnected ";
		format-paused = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Paused ";
		format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
		unknown-tag = "N/A";
		interval = 2;
		max-length = 70;
		on-click = "notify-music";
		on-click-right = "mpc toggle";
		on-scroll-up = "mpc volume +5";
		on-scroll-down = "mpc volume -5";
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
	};

	network = {
		format-wifi = "{essid} ({signalStrength}%) ";
		format-ethernet = "{ipaddr}/{cidr} ";
		tooltip-format = "{ifname} via {gwaddr} ";
		format-linked = "{ifname} (No IP) ";
		format-disconnected = "Disconnected ⚠";
		format-alt = "{ifname}: {ipaddr}/{cidr}";
	};

	network-traffic = {
		format = "{bandwidthUpBits} {bandwidthDownBits} ";
		format-alt = "{bandwidthUpBytes} {bandwidthDownBytes} ";
		format-disconnected = "Disconnected ⚠";
		interval = 1;
	};

	pulseaudio = {
		format = "{volume}% {icon} {format_source}";
		format-bluetooth = "{volume}% {icon} {format_source}";
		format-bluetooth-muted = " {icon} {format_source}";
		format-muted = " {format_source}";
		format-source = "{volume}% ";
		format-source-muted = "";
		format-icons = {
			headphone = "";
			hands-free = "";
			headset = "";
			phone = "";
			portable = "";
			car = "";
			default = [
				""
				""
				""
			];
		};
		on-click = "pavucontrol";
		on-click-right = "qpwgraph";
	};

	sway = {
		mode = {
			format = "<span style=\"italic\">{}</span>";
		};

		scratchpad = {
			format = "{icon} {count}";
			show-empty = false;
			format-icons = [
				""
				""
			];
			tooltip = true;
			tooltip-format = "{app}: {title}";
		};

		workspaces = {
			disable-scroll = true;
			all-outputs = true;
			format = "{name}: {icon}";
			format-icons = {
				"1" = "";
				"2" = "";
				"3" = "";
				"4" = "";
				"5" = "E";
				"6" = "";
				"7" = "";
				"8" = "";
				"9" = "";
				"urgent" = "";
				"focused" = "";
				"default" = "";
			};
		};
	};

	temperature = {
		critical-threshold = 80;
		format = "{temperatureC}°C {icon}";
		format-icons = [
			""
			""
			""
		];
	};

	tray = {
		spacing = 10;
	};

	wlr = {
		workspaces = {
			disable-scroll = true;
			all-outputs = true;
			active-only = false;
			format = "{name}: {icon}";
			format-icons = {
				"1" = "";
				"2" = "";
				"3" = "";
				"4" = "";
				"5" = "E";
				"6" = "";
				"7" = "";
				"8" = "";
				"9" = "";
				"urgent" = "";
				"focused" = "";
				"default" = "";
			};
			on-click = "activate";
			on-scroll-up = "hyprctl dispatch workspace e-1";
			on-scroll-down = "hyprctl dispatch workspace e+1";
		};
	};

	user = {
		format = "{work_H}H  ";
		interval = 60;
		height = 30;
		width = 30;
		icon = true;
	};

	wireplumber = {
		format = "{volume}% {icon}";
		format-muted = "";
		on-click = "helvum";
		format-icons = [
			""
			""
			""
		];
	};
		
in
{
	options = {
		waybar.enable = lib.mkEnableOption "Enable waybar module";
	};

	config = lib.mkIf config.waybar.enable {
		programs.waybar = {
			enable = true;

			systemd.enable = true;

			settings = {
				mainTopBar = {
					layer = "top";
					height = height;
					spacing = spacing;
					output = output;
					modules-left = [
						"idle_inhibitor"
						"hyprland/workspaces"
						"hyprland/window"
						"sway/mode"
						"sway/scratchpad"
					];
					modules-center = [
						"hyprland/submap"
					];
					modules-right = [
						"keyboard-state"
						"hyprland/language"
						"pulseaudio"
						"network"
						"backlight"
						"battery"
						"clock#date"
						"clock"
						"tray"
					];

					"backlight" = backlight;
					"battery" = battery;
					"clock" = clock;
					"clock#date" = clock-date;
					"hyprland/language" = hyprland.language;
					"hyprland/submap" = hyprland.submap;
					"hyprland/window" = hyprland.window;
					"hyprland/workspaces" = hyprland.workspaces;
					"idle_inhibitor" = idle_inhibitor;
					"keyboard-state" = keyboard-state;
					"network" = network;
					"pulseaudio" = pulseaudio;
					"sway/mode" = sway.mode;
					"sway/scratchpad" = sway.scratchpad;
					"tray" = tray;
				};

				mainBottomBar = {
					layer = "top";
					position = "bottom";
					height = height;
					spacing = spacing;
					output = output;
					modules-left = [
						"custom/power"
						"custom/kernel"
						"sway/scratchpad"
						"disk"
					];
					modules-center = [
						"mpd"
					];
					modules-right = [
						"custom/weather"
						"network#traffic"
						"cpu"
						"memory"
						"temperature"
						"user"
					];

					"custom/power" = custom.power;
					"custom/kernel" = custom.kernel;
					"sway/scratchpad" = sway.scratchpad;
					"disk" = disk;
					"disk#home" = disk-home;
					"mpd" = mpd;
					"custom/weather" = custom.weather;
					"network#traffic" = network-traffic;
					"cpu" = cpu;
					"memory" = memory;
					"temperature" = temperature;
					"user" = user;
				};
			};

			style = ''
			*  {
				font-family: "Liberation Sans", "Fira Code", "Font Awesome 6 Free", "Font Awesome 6 Brands", "Font Awesome 5 Free", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
				font-size: 16px;
				border: none;
				border-radius: 10px;
			}

			window#waybar {
				background: transparent;
			}

			tooltip {
				background: #1e1e2e;
				border-radius: 10px;
				border-width: 2px;
				border-style: solid;
				border-color: #11111b;
			}

			.modules-left,
			.modules-center,
			.modules-right
			{
				padding: 2px 10px 2px 10px;
				margin-top: 3px;
			}

			#backlight,
			#battery,
			#clock,
			#cpu,
			#custom-kernel,
			#custom-power,
			#custom-weather,
			#disk,
			#hyprland-language,
			#hyprland-submap,
			#hyprland-window,
			#idle_inhibitor,
			#keyboard-state,
			#memory,
			#mode,
			#mpd,
			#network,
			#pulseaudio,
			#scratchpad,
			#sway-mode,
			#sway-scratchpat,
			#sway-workspaces,
			#temperature,
			#tray,
			#user,
			#window,
			#wireplumber,
			#wlr-workspaces,
			#workspaces
			{
				padding: 0 10px;
				color: #ffffff;
				background: #1e1e2e;
			}

			#workspaces button {
				color: #a6adc8;
			}

			#workspaces button.active {
				color: #FFFFFF;
			}

			#workspaces button.focused {
				color: #a6adc8;
				background: #eba0ac;
				border-radius: 10px;
			}

			#workspaces button.urgent {
				color: red;
				background: yellow;
				border-radius: 10px;
			}

			#workspaces button:hover {
				background: grey;
				/* color: #cdd6f4; */
				border-radius: 10px;
			}

			#battery {
				background-color: #ffffff;
				color: #000000;
			}

			#battery.charging, #battery.plugged {
				color: #ffffff;
				background-color: #26A65B;
			}

			@keyframes blink {
				to {
					background-color: #ffffff;
					color: #000000;
				}
			}

			#battery.critical:not(.charging) {
				background-color: #f53c3c;
				color: #ffffff;
				animation-name: blink;
				animation-duration: 0.5s;
				animation-timing-function: linear;
				animation-iteration-count: infinite;
				animation-direction: alternate;
			}

			label:focus {
				background-color: #000000;
			}

			#clock {
				background-color: #64727D;
			}

			#cpu {
				background-color: #2ecc71;
				color: #000000;
			}

			#cpu.critical {
				color: red;
			}

			#disk {
				background-color: #c5700f;
			}

			#idle_inhibitor {
				background-color: #2d3436;
			}

			#idle_inhibitor.activated {
				background-color: #ecf0f1;
				color: #2d3436;
			}

			#keyboard-state {
				background: #97e1ad;
				color: #000000;
				padding: 0 0px;
				margin: 0 5px;
				min-width: 16px;
			}

			#keyboard-state > label {
				padding: 0 5px;
			}

			#keyboard-state > label.locked {
				background: rgba(0, 0, 0, 0.2);
			}

			#language {
				background: #00b093;
				color: #740864;
				padding: 0 5px;
			}

			#memory {
				background-color: #9b59b6;
			}

			#memory.warning {
				color: yellow;
			}

			#memory.critical {
				color: red;
			}

			#mpd {
				background-color: #66cc99;
				color: #2a5c45;
			}

			#mpd.disconnected {
				background-color: #f53c3c;
			}

			#mpd.stopped {
				background-color: #90b1b1;
			}

			#mpd.paused {
				background-color: #51a37a;
			}

			#network {
				background-color: #2980b9;
			}

			#network.disconnected {
				background-color: #f53c3c;
			}

			#pulseaudio {
				background-color: #f1c40f;
				color: black;
			}

			#pulseaudio.muted {
				background-color: #90b1b1;
				color: #2a5c45;
			}

			#temperature {
				background-color: #f0932b;
				color: black;
			}

			#temperature.critical {
				background-color: #eb4d4b;
			}

			#tray {
				margin-right: 10px;
			}

			#tray > .passive {
				-gtk-icon-effect: dim;
			}

			#tray > .needs-attention {
				-gtk-icon-effect: highlight;
				background-color: #eb4d4b;
			}

			#window#waybar-hidden {
				opacity: 0.2;
			}

			#wireplumber {
				background-color: #fff0f5;
				color: #000000;
			}

			#wireplumber.muted {
				background-color: #f53c3c;
			}
			'';
		};

		home.packages = with pkgs; [
			brightnessctl
			wlogout
		];
	};
}
