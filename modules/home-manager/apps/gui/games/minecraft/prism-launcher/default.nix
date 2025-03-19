{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (config.home) username;
  java8 = pkgs.temurin-bin-8;
  java17 = pkgs.temurin-bin-17;
  java21 = pkgs.temurin-bin-21;
  cfg = config.apps.gui.prism-launcher;
in
{
  options.apps.gui.prism-launcher.enable = lib.mkEnableOption "Enable prism-launcher module";

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.prismlauncher.override {
        jdks = [
          java8
          java17
          java21
        ];
      })
    ];
  };
}
