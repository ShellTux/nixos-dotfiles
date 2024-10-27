{ lib, config, ... }:
{
  options.apps.gui.kitty.enable = lib.mkEnableOption "Enable kitty module";

  config = lib.mkIf config.apps.gui.kitty.enable {
    programs.kitty = {
      enable = true;

      font = {
        # TODO: make sure to install fonts
        name = lib.mkDefault "JetBrains Mono";
        size = lib.mkDefault 12;
      };

      settings = {
        cursor_shape = "block";
        cursor_text_color = "background";
        background_opacity = lib.mkDefault "0.8";
        dim_opacity = lib.mkDefault "0.75";
        selection_foreground = lib.mkDefault "#000000";
        selection_background = lib.mkDefault "#fffacd";
        update_check_interval = 0;
        shell_integration = "no-cursor";
        # Nerd Fonts Version: 3.2.1
        symbol_map = "U+e000-U+e00a,U+e0a0-U+e0a2,U+e0b0-U+e0b3,U+e0a3-U+e0a3,U+e0b4-U+e0c8,U+e0cc-U+e0d2,U+e0d4-U+e0d4,U+e0d6-U+e0d7,U+e5fa-U+e6b2,U+e700-U+e7c5,U+f000-U+f2e0,U+e200-U+e2a9,U+f400-U+f4a8,U+2665-U+2665,U+26A1-U+26A1,U+f27c-U+f27c,U+f300-U+f372,U+23fb-U+23fe,U+2b58-U+2b58,U+f0001-U+f0010,U+e300-U+e3eb Symbols Nerd Font";
      };
    };
  };
}
