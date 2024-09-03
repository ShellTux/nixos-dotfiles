{ lib, config, ... }:
{
	options.zellij = {
		enable = lib.mkEnableOption "Enable zellij module";

		enableBashIntegration = lib.mkOption {
			description = "Whether to enable bash integration.";
			type = lib.types.bool;
			default = false;
		};

		enableZshIntegration = lib.mkOption {
			description = "Whether to enable zsh integration.";
			type = lib.types.bool;
			default = false;
		};
	};

	config = lib.mkIf config.zellij.enable {
		programs.zellij = {
			enable = true;

			enableBashIntegration = config.zellij.enableBashIntegration;
			enableZshIntegration = config.zellij.enableZshIntegration;

			settings = {
				ui.pane_frames = {
					hide_session_name = true;
					rounded_corners = true;
				};
				plugins = {
					compact-bar.path = "compact-bar";
					session-manager.path = "session-manager";
					status-bar.path = "status-bar";
					strider.path = "strider";
					tab-bar.path = "tab-bar";
				};
				vimTmuxNavigatorKeybinds = true;
				whichKeyEnabled = true;
				replaceVimWindowNavigationKeybinds = true;
				theme = "tokyo-night";

				keybinds =
				let
					mode = {
						normal = "Normal";
						renameTab = "RenameTab";
						scroll = "Scroll";
						tmux = "Tmux";
					};
					pane = {
						down = "Down";
						left = "Left";
						right = "Right";
						up = "Up";
					};
					search = {
						down = "Down";
						up = "Up";
					};

					moveFocus = direction: {  MoveFocus = direction; SwitchToMode = mode.normal;  };
				in 
				{
					normal = {
						"bind \"Ctrl s\"" = { ToggleFloatingPanes = []; };
					};

					tmux = {
						"bind \"[\"" = {  SwitchToMode = mode.scroll;  };
						"bind \"Ctrl Space\"" = {  Write = 2; SwitchToMode = mode.normal;  };
						"bind \"\\\"\"" = {  NewPane = pane.down; SwitchToMode = mode.normal;  };
						"bind \"-\"" = {  NewPane = pane.down; SwitchToMode = mode.normal;  };
						"bind \"%\"" = {  NewPane = pane.right; SwitchToMode = mode.normal;  };
						"bind \"|\"" = {  NewPane = pane.right; SwitchToMode = mode.normal;  };
						"bind \"z\"" = {  ToggleFocusFullscreen = []; SwitchToMode = mode.normal;  };
						"bind \"c\"" = {  NewTab = []; SwitchToMode = mode.normal;  };
						"bind \",\"" = {  SwitchToMode = mode.renameTab;  };
						"bind \"p\"" = {  GoToPreviousTab = []; SwitchToMode = mode.normal;  };
						"bind \"n\"" = {  GoToNextTab = []; SwitchToMode = mode.normal;  };
						"bind \"Left\" \"h\"" = moveFocus pane.left;
						"bind \"Right\" \"l\"" = moveFocus pane.right;
						"bind \"Down\" \"j\"" = moveFocus pane.down;
						"bind \"Up\" \"k\"" = moveFocus pane.up;
						"bind \"o\"" = {  FocusNextPane = [];  };
						"bind \"d\"" = {  Detach = [];  };
						"bind \"Space\"" = {  NextSwapLayout = [];  };
						"bind \"x\"" = {  CloseFocus = []; SwitchToMode  = mode.normal;  };
					};

					scroll = {
						"bind \"g\"" = { ScrollToTop = []; };
						"bind \"G\"" = { ScrollToBottom = []; };
						"bind \"/\"" = { Search = search.down; };
						"bind \"?\"" = { Search = search.up; };
						"bind \"Ctrl u\"" = { HalfPageScrollUp = []; };
						"bind \"Ctrl d\"" = { HalfPageScrollDown = []; };
						"bind \"Ctrl f\"" = { PageScrollUp = []; };
						"bind \"Ctrl b\"" = { PageScrollDown = []; };
					};

					shared_except = {
						_args = ["tmux" "locked"];
						"bind \"Ctrl Space\"" = { SwitchToMode = mode.tmux; };
					};
				};
			};
		};

		xdg.configFile."zellij/themes" = {
			recursive = true;
			source = ./themes;
		};
	};
}
