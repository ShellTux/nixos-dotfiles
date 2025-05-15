{ lib, config, ... }:
let
  cfg = config.programs.nixvim.plugins.render-markdown;
in
{
  programs.nixvim.plugins.render-markdown.settings = lib.mkIf cfg.enable {
    html.comment = {
      text = "󰆈";
      conceal = false;
    };
  };
}
