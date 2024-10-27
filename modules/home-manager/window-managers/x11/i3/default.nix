{
  pkgs,
  lib,
  config,
  ...
}:
let
  brightnessScript = import ../../brightness.nix { inherit pkgs; };
  volumeScript = import ../../volume.nix { inherit pkgs; };

  modifier = "Mod4";

  workspaces = {
    "1" = "1: ";
    "2" = "2: ";
    "3" = "3: ";
    "4" = "4: ";
    "5" = "5: E";
    "6" = "6: ";
    "7" = "7: ";
    "8" = "8: ";
    "9" = "9: ";
    "0" = "0: ";
  };

  window = {
    titlebar = false;
    border = 1;
  };

  gaps = {
    inner = 5;
    outer = 5;
    top = 5;
    bottom = 5;
  };

  terminal = "${pkgs.kitty}/bin/kitty";
in
{
  options.i3.enable = lib.mkEnableOption "Enable i3 module";

  config = lib.mkIf config.i3.enable {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;

      config = rec {
        inherit
          terminal
          gaps
          modifier
          window
          ;

        bars = [
          {
            position = "top";
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
          }
          {
            position = "bottom";
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-bottom.toml";
          }
        ];

        keybindings =
          let
            focus = {
              down = "focus down";
              left = "focus left";
              right = "focus right";
              up = "focus up";
              toggleMode = "focus toggle_mode";
            };
            move = {
              down = "move down";
              left = "move left";
              right = "move right";
              up = "move up";
            };
            workspace = {
              goto = {
                "1" = "workspace ${workspaces."1"}";
                "2" = "workspace ${workspaces."2"}";
                "3" = "workspace ${workspaces."3"}";
                "4" = "workspace ${workspaces."4"}";
                "5" = "workspace ${workspaces."5"}";
                "6" = "workspace ${workspaces."6"}";
                "7" = "workspace ${workspaces."7"}";
                "8" = "workspace ${workspaces."8"}";
                "9" = "workspace ${workspaces."9"}";
                "0" = "workspace ${workspaces."0"}";
              };
              moveWindowTo = {
                "1" = "move container to workspace ${workspaces."1"}";
                "2" = "move container to workspace ${workspaces."2"}";
                "3" = "move container to workspace ${workspaces."3"}";
                "4" = "move container to workspace ${workspaces."4"}";
                "5" = "move container to workspace ${workspaces."5"}";
                "6" = "move container to workspace ${workspaces."6"}";
                "7" = "move container to workspace ${workspaces."7"}";
                "8" = "move container to workspace ${workspaces."8"}";
                "9" = "move container to workspace ${workspaces."9"}";
                "0" = "move container to workspace ${workspaces."0"}";
              };
            };
            i3Commands = {
              exit = ''exec "i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'yes' 'i3-msg exit'"'';
              killWindow = "kill";
              reloadConfig = "reload";
              restart = "restart";
            };
            mod = modifier;
          in
          {
            # Volume
            "XF86AudioMute" = "exec ${volumeScript}/bin/volume toggle-mute";
            "XF86AudioLowerVolume" = "exec ${volumeScript}/bin/volume 5 -";
            "XF86AudioRaiseVolume" = "exec ${volumeScript}/bin/volume 5 +";

            # Music
            "XF86AudioPlay" = "exec ${pkgs.mpc-cli}/bin/mpc toggle";
            "XF86AudioPrev" = "exec ${pkgs.mpc-cli}/bin/mpc prev";
            "XF86AudioNext" = "exec ${pkgs.mpc-cli}/bin/mpc next";

            # Brightness
            "XF86MonBrightnessDown" = "exec ${brightnessScript}/bin/brightness 5 -";
            "XF86MonBrightnessUp" = "exec ${brightnessScript}/bin/brightness 5 +";

            "${mod}+Return" = "exec ${terminal}";
            "${mod}+p" = "exec ${pkgs.rofi}/bin/rofi -modi drun -show drun -show-icons";
            "${mod}+Shift+p" = "exec ${pkgs.rofi}/bin/rofi -show window";
            "${mod}+c" = i3Commands.killWindow;
            "${mod}+Shift+r" = i3Commands.reloadConfig;
            "${mod}+Ctrl+Shift+r" = i3Commands.restart;
            "${mod}+Shift+q" = i3Commands.exit;

            "${mod}+j" = focus.down;
            "${mod}+k" = focus.up;
            "${mod}+l" = focus.right;
            "${mod}+h" = focus.left;
            "${mod}+Shift+space" = focus.toggleMode;

            "${mod}+Shift+j" = move.down;
            "${mod}+Shift+k" = move.up;
            "${mod}+Shift+l" = move.right;
            "${mod}+Shift+h" = move.left;

            "${mod}+f" = "fullscreen toggle";
            "${mod}+space" = "floating toggle";

            "${mod}+1" = workspace.goto."1";
            "${mod}+2" = workspace.goto."2";
            "${mod}+3" = workspace.goto."3";
            "${mod}+4" = workspace.goto."4";
            "${mod}+5" = workspace.goto."5";
            "${mod}+6" = workspace.goto."6";
            "${mod}+7" = workspace.goto."7";
            "${mod}+8" = workspace.goto."8";
            "${mod}+9" = workspace.goto."9";
            "${mod}+0" = workspace.goto."0";
            "${mod}+Left" = "workspace prev";
            "${mod}+Right" = "workspace next";
            "${mod}+Shift+1" = workspace.moveWindowTo."1";
            "${mod}+Shift+2" = workspace.moveWindowTo."2";
            "${mod}+Shift+3" = workspace.moveWindowTo."3";
            "${mod}+Shift+4" = workspace.moveWindowTo."4";
            "${mod}+Shift+5" = workspace.moveWindowTo."5";
            "${mod}+Shift+6" = workspace.moveWindowTo."6";
            "${mod}+Shift+7" = workspace.moveWindowTo."7";
            "${mod}+Shift+8" = workspace.moveWindowTo."8";
            "${mod}+Shift+9" = workspace.moveWindowTo."9";
            "${mod}+Shift+0" = workspace.moveWindowTo."0";
          };

        startup = [
          {
            command = "exec i3-msg workspace 1";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.feh}/bin/feh --bg-scale ~/background.png";
            always = true;
            notification = false;
          }
        ];

        assigns = {
          "${workspaces."9"}" = [ { class = "Discord"; } ];
          "${workspaces."2"}" = [
            { class = "Google-chrome"; }
            { class = "firefox"; }
          ];
        };
      };
    };

    programs.i3status-rust = {
      enable = true;

      bars = {
        top = {
          blocks = [
            {
              block = "memory";
              format = " $icon mem_used_percents ";
              format_alt = " $icon $swap_used_percents ";
            }
            {
              block = "cpu";
              interval = 1;
            }
            {
              block = "load";
              format = " $icon $1m ";
              interval = 1;
            }
            {
              block = "sound";
            }
            {
              block = "time";
              format = " $timestamp.datetime(f:'%a %d/%m %R') ";
              interval = 60;
            }
          ];
        };
        bottom = {
          blocks = [
            {
              block = "disk_space";
              path = "/";
              info_type = "available";
              interval = 60;
              warning = 20.0;
              alert = 10.0;
            }
            {
              block = "memory";
              format_mem = " $icon $mem_used_percents ";
              format_swap = " $icon $swap_used_percents ";
            }
            {
              block = "cpu";
              interval = 1;
            }
            {
              block = "load";
              interval = 1;
              format = " $icon $1m ";
            }
            { block = "sound"; }
            {
              block = "time";
              interval = 60;
              format = " $timestamp.datetime(f:'%a %d/%m %R') ";
            }
          ];
          settings = {
            theme = {
              theme = "solarized-dark";
              overrides = {
                idle_bg = "#123456";
                idle_fg = "#abcdef";
              };
            };
          };
          icons = "awesome5";
          theme = "gruvbox-dark";
        };
      };
    };
  };
}
