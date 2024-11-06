{ lib, config, ... }:
let
  cfg = config.programs.nixvim.plugins.lualine;
in
{
  programs.nixvim = {

    extraConfigLua = lib.mkIf cfg.enable "vim.cmd [[ highlight MacroRecording guifg=#FF0000 ]]";

    plugins.lualine = lib.mkIf cfg.enable {
      settings.sections = {
        lualine_a = [
          {
            __raw = "function() local recording_register = vim.fn.reg_recording(); return (recording_register ~= '') and ('%#MacroRecording#󰑊 @' .. recording_register) or '' end";
          }
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
