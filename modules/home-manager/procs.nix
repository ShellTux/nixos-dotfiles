{ lib, config, pkgs, ... }:
{
	options.procs.enable = lib.mkEnableOption "Enable procs module";

	config = lib.mkIf config.procs.enable {
		home.packages = with pkgs; [
			procs
		];
	};
}
