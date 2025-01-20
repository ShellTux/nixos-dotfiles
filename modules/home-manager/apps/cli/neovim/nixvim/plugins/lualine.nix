{ lib, config, ... }:
let
  cfg = config.programs.nixvim.plugins.lualine;
  noice-cfg = config.programs.nixvim.plugins.noice;
in
{
  programs.nixvim = {

    extraConfigLua = lib.mkIf cfg.enable "vim.cmd [[ highlight MacroRecording guifg=#FF0000 ]]";

    plugins.lualine = lib.mkIf cfg.enable {
      settings.sections = {
        lualine_a = [
          (lib.mkIf noice-cfg.enable {
            __unkeyed-1.__raw = ''
              function()
                return require('noice').api.statusline.mode.get():gsub('recording', '󰑊')
              end
            '';
            cond.__raw = ''
              function()
                local noice = require("noice")
                if noice.api.statusline.mode.has() and noice.api.statusline.mode.get():find("^recording") then
                  return true
                else
                  return false
                end
              end
            '';
            color.fg = "#ff0000";
          })
          (lib.mkIf (noice-cfg.enable == false) {
            __raw = "function() local recording_register = vim.fn.reg_recording(); return (recording_register ~= '') and ('%#MacroRecording#󰑊 @' .. recording_register) or '' end";
          })
          "mode"
        ];
        lualine_x = [
          { __raw = "function() return ' ' .. vim.g.colors_name end"; }
          "encoding"
          "fileformat"
          "filetype"
        ];
      };
    };
  };
}
