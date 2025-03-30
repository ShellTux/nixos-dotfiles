{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.nixvim.plugins.lsp-lines;
in
{
  programs.nixvim = {
    diagnostics = mkIf cfg.enable {
      virtual_lines.only_current_line = true;
    };
  };
}
