{ lib, config, pkgs, ... }:
{
	options.nvtop = {
		enable = lib.mkEnableOption "Enable nvtop module";

		backend = lib.mkOption {
			description = "Which backend to enable";
			type = with lib.types; listOf (enum [ "nvidia" "amd" "intel" "panthor" "panfrost" "msm" ]);
			default = [ "amd" ];
		};
	};

	config = lib.mkIf config.nvtop.enable {
		home.packages = [
			(
			 if (lib.length config.nvtop.backend > 1) then
			 pkgs.nvtopPackages.full
			 else pkgs.nvtopPackages.${lib.elemAt config.nvtop.backend 0}
			)
		];
	};
}
