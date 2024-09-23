{ lib, config, ... }:
{
	options.docker.enable = lib.mkEnableOption "Enable docker module";

	config.virtualisation.docker.enable = lib.mkIf config.docker.enable true;
}
