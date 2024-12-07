{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.cli.tgpt.enable = lib.mkEnableOption "Enable tgpt module";

  config = lib.mkIf config.apps.cli.tgpt.enable {
    home.packages = [
      pkgs.tgpt
    ];

    home.shellAliases."?" = "tgpt";
  };
}
