{ lib, ... }:
{
  programs.nixvim = {
    colorscheme = lib.mkForce "tokyonight";

    colorschemes = {
      catppuccin.enable = true;
      dracula.enable = true;
      everforest.enable = true;
      gruvbox.enable = true;
      kanagawa.enable = true;
      nightfox.enable = true;
      nord.enable = true;
      onedark.enable = true;
      tokyonight.enable = true;
      vscode.enable = true;
    };
  };
}
