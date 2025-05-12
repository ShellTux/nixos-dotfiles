{ lib, config, ... }:
{
  options.apps.gui.rio.enable = lib.mkEnableOption "Enable rio module";

  config = lib.mkIf config.apps.gui.rio.enable {
    programs.rio = {
      enable = true;

      settings = {
        hide-cursor-when-typing = true;

        cursor = {
          shape = "block";
          blinking = true;
          blinking-interval = 800;
        };

        editor.program = "vim";

        window.opacity = lib.mkDefault 0.8;
        fonts = {
          family = lib.mkDefault "JetBrains Mono";
          symbol-map = [
            {
              start = "e000";
              end = "e00a";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "e0a0";
              end = "e0a2";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "e0b0";
              end = "e0b3";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "e0a3";
              end = "e0a3";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "e0b4";
              end = "e0c8";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "e0cc";
              end = "e0d2";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "e0d4";
              end = "e0d4";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "e0d6";
              end = "e0d7";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "e5fa";
              end = "e6b2";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "e700";
              end = "e7c5";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "f000";
              end = "f2e0";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "e200";
              end = "e2a9";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "f400";
              end = "f4a8";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "2665";
              end = "2665";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "26A1";
              end = "26A1";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "f27c";
              end = "f27c";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "f300";
              end = "f372";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "23fb";
              end = "23fe";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "2b58";
              end = "2b58";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "f0001";
              end = "f0010";
              font-family = "Symbols Nerd Font";
            }
            {
              start = "e300";
              end = "e3eb";
              font-family = "Symbols Nerd Font";
            }
          ];
        };
        shell = {
          program = "tmux";
          args = [ "new-session" ];
        };
      };
    };
  };
}
