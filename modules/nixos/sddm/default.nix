{ lib, config, pkgs, ... }:
let
	sddm-themes = pkgs.callPackage ./themes {};
	packages = with pkgs; [
		bibata-cursors
		sddm
		sddm-themes
	] ++ (with pkgs.libsForQt5.qt5; [
		qtgraphicaleffects
		qtmultimedia
		qtquickcontrols
	]) ++ (with pkgs.gst_all_1; [
		gst-plugins-good
		gst-plugins-bad
	]);
in
{
	options.sddm = {
		enable = lib.mkEnableOption "Enable sddm module";
	};

	config = lib.mkIf config.sddm.enable {
		services.displayManager.sddm = {
			enable = true;

			autoNumlock = true;
			theme = "sddm-lain-wired-theme";
			wayland.enable = true;

			settings.Theme = {
				EnableAvatars = true;
				DisableAvatarsThreshold = 7;
				CursorSize = 16;
				## Does not work to change SDDM cursor theme
				## see profile/desktop.nix for how this is changed
				CursorTheme = "bibata-cursors";
			};
		};

		environment.systemPackages = packages;
	};
}
