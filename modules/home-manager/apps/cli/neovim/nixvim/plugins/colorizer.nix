{ lib, config, ... }:
let
  cfg = config.programs.nixvim.plugins.colorizer;
in
{
  programs.nixvim = {
    plugins.colorizer.settings = lib.mkIf cfg.enable {
      filetypes = {
        __unkeyed-1 = "*";
        __unkeyed-2 = "!vim";
        css.gb_fn = true;
        html.names = false;
      };
    };
  };
}
