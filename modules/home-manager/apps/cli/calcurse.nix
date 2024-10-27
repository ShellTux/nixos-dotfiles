{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.cli.calcurse.enable = lib.mkEnableOption "Enable calcurse module";

  config = lib.mkIf config.apps.cli.calcurse.enable {
    home.packages = with pkgs; [
      calcurse
    ];
  };
}
