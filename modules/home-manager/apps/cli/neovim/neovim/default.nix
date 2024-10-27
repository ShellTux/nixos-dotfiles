{ lib, pkgs, ... }:
{
  config = {
    programs.neovim = {
      defaultEditor = true;

      extraLuaConfig = lib.fileContents ./init.lua;

      # TODO: Plugins

      extraPackages = with pkgs; [
        wl-clipboard
        xclip
      ];

    };

    home.packages = with pkgs; [
      ripgrep
      wl-clipboard
      xclip
    ];
  };
}
