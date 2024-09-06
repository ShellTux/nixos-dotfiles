{ pkgs, lib, config, ... }:
{
	options.awesome.enable = lib.mkEnableOption "Enable awesome module";

	config = lib.mkIf config.awesome.enable {
		services.xserver.windowManager.awesome = {
			enable = true;
		};

		environment.systemPackages = with pkgs; [
			dunst
			firefox
			kitty
			libnotify
		];

		xdg.portal = {
			enable = true;
			
			extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
		};

		hardware.graphics.enable = true;
	};
}
