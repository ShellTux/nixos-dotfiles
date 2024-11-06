{ lib, config, ... }:
let
  cfg = config.programs.nixvim.plugins.auto-save;
in
{
  programs.nixvim = {
    plugins.auto-save.settings = lib.mkIf cfg.enable {
      enabled = true;
      debounce_delay = 5 * 1000;
    };
    keymaps = lib.mkIf cfg.enable [
      {
        action = "<cmd>ASToggle<CR>";
        key = "<leader>st";
        options = {
          silent = true;
          desc = "Toggle auto-save";
        };
      }
    ];
  };
}
