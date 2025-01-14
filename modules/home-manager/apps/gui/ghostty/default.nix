{ lib, config, ... }:
{
  options.apps.gui.ghostty.enable = lib.mkEnableOption "Enable ghostty module";

  config = lib.mkIf config.apps.gui.ghostty.enable {
    programs.ghostty = {
      enable = true;

      enableBashIntegration = true;
      enableZshIntegration = true;
      installVimSyntax = config.programs.vim.enable;

      settings = {
        auto-update = "off";
        cursor-style = "bar";
        font-size = 14;
        gtk-titlebar = false;
        mouse-hide-while-typing = true;
        resize-overlay = "never";
        term = "xterm-ghostty";
        theme = "catppuccin-mocha";
        window-decoration = false;
      };

      themes = {
        catppuccin-mocha = {
          background = "1e1e2e";
          cursor-color = "f5e0dc";
          foreground = "cdd6f4";
          palette = [
            "0=#45475a"
            "1=#f38ba8"
            "2=#a6e3a1"
            "3=#f9e2af"
            "4=#89b4fa"
            "5=#f5c2e7"
            "6=#94e2d5"
            "7=#bac2de"
            "8=#585b70"
            "9=#f38ba8"
            "10=#a6e3a1"
            "11=#f9e2af"
            "12=#89b4fa"
            "13=#f5c2e7"
            "14=#94e2d5"
            "15=#a6adc8"
          ];
          selection-background = "353749";
          selection-foreground = "cdd6f4";
        };
      };
    };
  };
}
