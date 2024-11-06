{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.screenkey;
  screenkey = pkgs.vimUtils.buildVimPlugin {
    name = "screenkey.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "NStefan002";
      repo = "screenkey.nvim";
      rev = "v2.4.1";
      hash = "sha256-RTUkG77gM6b1PKv5AqB0/U4satHwQ+q5kJYM3U/mkAw=";
    };
  };
in
{
  options.programs.nixvim.plugins.screenkey.enable = lib.mkEnableOption "Wether to enable screenkey.nvim";

  config.programs.nixvim = {
    extraPlugins = lib.mkIf cfg.enable [ screenkey ];
    globals.screenkey_statusline_component = lib.mkIf cfg.enable true;
    keymaps = lib.mkIf cfg.enable [
      {
        action = "<cmd>Screenkey toggle<CR>";
        key = "<leader>sc";
        options = {
          silent = true;
          desc = "Toggle Screenkey";
        };
      }
      {
        action = "<cmd>Screenkey toggle_statusline_component<CR>";
        key = "<leader>scc";
        options = {
          silent = true;
          desc = "Toggle Screenkey status line";
        };
      }
    ];

    plugins.lualine.settings.sections.lualine_c = lib.mkIf cfg.enable [
      "filename"
      { __raw = "function() return ' ' .. require('screenkey').get_keys() end"; }
    ];
  };
}
