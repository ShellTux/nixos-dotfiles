{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib) getExe;

  cfg = config.programs.nixvim.plugins.jdtls;

  jdtls = getExe pkgs.jdt-language-server;
in
{
  programs.nixvim = {
    plugins.jdtls = mkIf cfg.enable {
      settings = {
        cmd = [
          "${jdtls}"
          "-data"
          "${config.xdg.cacheHome}/jdtls/workspace"
          "-configuration"
          "${config.xdg.cacheHome}/jdtls/config"
        ];
      };
    };
  };
}
