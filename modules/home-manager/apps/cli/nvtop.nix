{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.cli.nvtop = {
    enable = lib.mkEnableOption "Enable nvtop module";

    backend = lib.mkOption {
      description = "Which backend to enable";
      type =
        with lib.types;
        listOf (enum [
          "nvidia"
          "amd"
          "intel"
          "panthor"
          "panfrost"
          "msm"
        ]);
      default = [ "amd" ];
    };
  };

  config = lib.mkIf config.apps.cli.nvtop.enable {
    home.packages = [
      (
        if (lib.length config.apps.cli.nvtop.backend > 1) then
          pkgs.nvtopPackages.full
        else
          pkgs.nvtopPackages.${lib.elemAt config.apps.cli.nvtop.backend 0}
      )
    ];
  };
}
