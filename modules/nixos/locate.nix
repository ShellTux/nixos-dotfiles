{ lib, config, pkgs, ... }:
{
	options.locate = {
		enable = lib.mkEnableOption "Enable locate module";

		pruneNixStore = lib.mkOption {
			description = "Wether to prune /nix/store path.";
			type = lib.types.bool;
			default = true;
		};
	};

	config = lib.mkIf config.locate.enable {
		services.locate = {
			enable = true;
			package = pkgs.plocate;
			localuser = null;
			prunePaths = [
				"/tmp"
				"/var/tmp"
				"/var/cache"
				"/var/lock"
				"/var/run"
				"/var/spool"
				(lib.mkIf config.locate.pruneNixStore "/nix/store")
				"/nix/var/log/nix"
			];
		};
	};
}
