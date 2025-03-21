{ ... }:
let
  leader = " ";
in
{
  programs.nixvim = {
    globals = {
      mapleader = leader;
      maplocalleader = leader;
      favorite_colorschemes = [
        "adwaita"
        "carbonfox"
        "catppuccin"
        "catppuccin-mocha"
        "dracula"
        "duskfox"
        "everforest"
        "github_dark"
        "gruvbox"
        "habamax"
        "kanagawa"
        "kanagawa-dragon"
        "nightfox"
        "nord"
        "nordfox"
        "onedark"
        "retrobox"
        "terafox"
        "tokyonight"
        "tokyonight-moon"
        "tokyonight-night"
        "tokyonight-storm"
      ];
    };

    opts = {
      background = "dark";
      encoding = "UTF-8";
      expandtab = true;
      exrc = true;
      hlsearch = true;
      ignorecase = true;
      incsearch = true;
      linebreak = false;
      listchars = "tab:>-,trail:•,nbsp:~";
      list = true;
      mouse = "";
      number = true;
      relativenumber = false;
      scrolloff = 999;
      shiftwidth = 4;
      sidescrolloff = 10;
      signcolumn = "yes";
      smartcase = true;
      smartindent = true;
      softtabstop = 4;
      syntax = "enabled";
      termguicolors = true;
      wildignore = "*.o,*.a,__pycache__";
      wildmenu = true;
      wrap = false;
    };

    autoCmd = [
      {
        desc = "Highlight when yanking (copying) text";
        group = "kickstart-highlight-yank";
        event = [ "TextYankPost" ];
        callback.__raw = "function() vim.highlight.on_yank() end";
      }
    ];

    autoGroups = {
      kickstart-highlight-yank = {
        clear = true;
      };
    };

    match = {
      ExtraWhitespace = "\\s\\+$";
    };
  };
}
