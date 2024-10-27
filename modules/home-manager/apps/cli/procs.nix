{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.cli.procs.enable = lib.mkEnableOption "Enable procs module";

  config = lib.mkIf config.apps.cli.procs.enable {
    home.packages = with pkgs; [
      procs
    ];
  };
}
