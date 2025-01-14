{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.cli.bc.enable = lib.mkEnableOption "Enable bc module";

  config = lib.mkIf config.apps.cli.bc.enable {
    home.packages = with pkgs; [
      bc
    ];
  };
}
