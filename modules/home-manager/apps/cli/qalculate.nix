{ lib, config, pkgs, ... }:
{
	options.apps.cli.qalculate = {
		enable = lib.mkEnableOption "Enable qalculate module";

		gui = {
			gtk.enable = lib.mkEnableOption "Enable Qalculate GTK Gui.";
			qt.enable = lib.mkEnableOption "Enable Qalculate Qt Gui.";
		};
	};

	config = lib.mkIf config.apps.cli.qalculate.enable {
		home.packages = with pkgs; [
			libqalculate
			(lib.mkIf config.apps.cli.qalculate.gui.gtk.enable qalculate-gtk)
			(lib.mkIf config.apps.cli.qalculate.gui.qt.enable qalculate-qt)
		];
	};
}
