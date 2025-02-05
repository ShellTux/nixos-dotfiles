{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.vim-polyglot;
in
{
  options.programs.nixvim.plugins.vim-polyglot.enable =
    lib.mkEnableOption "Wether to enable vim-polyglot";

  config.programs.nixvim = {
    extraPlugins = lib.mkIf cfg.enable [ pkgs.vimPlugins.vim-polyglot ];
  };
}
