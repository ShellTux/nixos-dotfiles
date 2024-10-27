{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    vim.enable = lib.mkEnableOption "Enable vim module";
  };

  config = lib.mkIf config.vim.enable {
    programs.vim = {
      enable = true;
    };
  };
}
