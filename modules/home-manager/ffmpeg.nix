{ lib, config, pkgs, ... }:
{
	options.ffmpeg = {
		enable = lib.mkEnableOption "Enable ffmpeg module";

		package = lib.mkOption {
			type = lib.types.package;
			default = pkgs.ffmpeg;
			description = "The ffmpeg package to use.";
		};
	};

	config = lib.mkIf config.ffmpeg.enable {
		home.packages = [
			config.ffmpeg.package
		];
	};
}
