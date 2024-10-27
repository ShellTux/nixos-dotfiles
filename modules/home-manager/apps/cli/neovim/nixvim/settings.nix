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
      exrc = true;
      hlsearch = true;
      ignorecase = true;
      incsearch = true;
      linebreak = false;
      listchars = "tab:> ,trail:•,nbsp:~";
      mouse = "nvia";
      number = true;
      relativenumber = false;
      scrolloff = 999;
      sidescrolloff = 10;
      signcolumn = "yes";
      smartcase = true;
      syntax = "enabled";
      termguicolors = true;
      wildignore = "*.o,*.a,__pycache__";
      wildmenu = true;
      wrap = false;
    };
  };
}
