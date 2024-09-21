{ lib, config, pkgs, ... }:
{
	options.apps.gui.xournalpp.enable = lib.mkEnableOption "Enable xournalpp module";

	config = lib.mkIf config.apps.gui.xournalpp.enable {
		home.packages = with pkgs; [
			xournalpp
		];
	};
}
