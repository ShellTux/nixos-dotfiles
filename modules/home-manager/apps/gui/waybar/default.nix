{ pkgs, lib, config, ... }:
let
	height = 30;
	spacing = 4;
	output = [
		"eDP-1"
		"HDMI-A-1"
	];


	backlight = import ./modules/backlight.nix { inherit pkgs; };
	battery = import ./modules/battery.nix { };
	clock = import ./modules/clock.nix { };
	clock-date = import ./modules/clock-date.nix { };
	cpu = import ./modules/cpu.nix { };
	custom = import ./modules/custom { inherit pkgs; };
	disk = import ./modules/disk.nix { };
	disk-home = import ./modules/disk-home.nix { };
	hyprland = import ./modules/hyprland { inherit pkgs; };
	idle_inhibitor = import ./modules/idle_inhibitor.nix { };
	keyboard-state = import ./modules/keyboard-state.nix { };
	memory = import ./modules/memory.nix { };
	mpd = import ./modules/mpd.nix { inherit pkgs; };
	network = import ./modules/network.nix { };
	network-traffic = import ./modules/network-traffic.nix { };
	pulseaudio = import ./modules/pulseaudio.nix { inherit pkgs; };
	sway = import ./modules/sway { };
	temperature = import ./modules/temperature.nix { };
	tray = import ./modules/tray.nix { };
	wlr = import ./modules/wlr { };
	user = import ./modules/user.nix { };
	wireplumber = import ./modules/wireplumber.nix { inherit pkgs; };
in
{
	options.apps.gui.waybar.enable = lib.mkEnableOption "Enable waybar module";

	config = lib.mkIf config.apps.gui.waybar.enable {
		programs.waybar = {
			enable = true;

			settings = {
				mainTopBar = {
					layer = "top";
					height = height;
					spacing = spacing;
					output = output;
					reload_style_on_change = true;
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

			style = lib.fileContents ./style.css;
		};
	};
}
