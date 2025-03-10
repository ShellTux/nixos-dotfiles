{ lib, config, ... }:
let
  cfg = config.programs.nixvim.plugins.nvim-jdtls;
in
{
  programs.nixvim = {
    plugins.nvim-jdtls = lib.mkIf cfg.enable {
      data = "/home/${config.home.username}/.cache/jdtls/workspace";
      configuration = "/home/${config.home.username}/.cache/jdtls/config";
      rootDir.__raw = "require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml'})";
    };
  };
}
