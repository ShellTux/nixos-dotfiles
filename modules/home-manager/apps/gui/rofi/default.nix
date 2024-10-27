{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.apps.gui.rofi.enable = lib.mkEnableOption "Enable rofi module";

  config = lib.mkIf config.apps.gui.rofi.enable {
    programs.rofi = {
      enable = true;

      plugins = with pkgs; [
        rofi-calc
        rofi-emoji
      ];
      theme = lib.mkDefault "tokyonight";
      # TODO: use terminal defined in settings
      terminal = "${pkgs.kitty}/bin/kitty";

      extraConfig = {
        modi = "drun,window,ssh,run,windowcd,combi,keys";
        show-icons = true;
        drun-display-format = "{icon} {name}";
        disable-history = false;
        hide-scrollbar = true;
        display-drun = "   Apps ";
        sidebar-mode = true;
      };
    };

    xdg.configFile."rofi/themes" = {
      source = ./themes;
      recursive = true;
    };
  };
}
