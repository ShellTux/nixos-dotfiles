{ ... }:
{
  programs.nixvim.plugins.lualine = {
    enable = true;

    settings.sections.lualine_x = [
      { __raw = "function() return ' ' .. vim.g.colors_name end"; }
      "encoding"
      "fileformat"
      "filetype"
    ];
  };
}
