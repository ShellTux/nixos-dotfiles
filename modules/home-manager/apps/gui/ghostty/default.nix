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
        font-size = 12;
        gtk-titlebar = false;
        mouse-hide-while-typing = true;
        resize-overlay = "never";
        term = "xterm-ghostty";
        theme = "tokyonight_moon";
        window-decoration = false;
      };

      settings.keybind = [
        "ctrl+page_up=unbind"
        "ctrl+page_down=unbind"
        "ctrl+shift+page_up=unbind"
        "ctrl+shift+page_down=unbind"
      ];
    };
  };
}
