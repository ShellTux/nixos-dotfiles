{
  pkgs,
  ...
}:
let
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
  config.programs.nixvim = {
    extraPlugins = [ screenkey ];
    globals.screenkey_statusline_component = true;
    keymaps = [
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
    plugins.lualine.settings.sections.lualine_c = [
      "filename"
      { __raw = "function() return ' ' .. require('screenkey').get_keys() end"; }
    ];
  };
}
