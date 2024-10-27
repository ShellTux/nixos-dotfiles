{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.apps.cli.tmux.enable = lib.mkEnableOption "Enable tmux module";

  config = lib.mkIf config.apps.cli.tmux.enable {
    programs.tmux = {
      enable = true;

      baseIndex = 1;
      clock24 = true;
      escapeTime = 100;
      historyLimit = 10000;
      keyMode = "vi"; # emacs, vi
      mouse = true;
      prefix = "C-space";
      sensibleOnTop = true;
      terminal = "screen-256color";

      plugins = with pkgs.tmuxPlugins; [
        catppuccin
        vim-tmux-navigator
      ];

      # TODO: Move extra config to separate file
      extraConfig = lib.mkMerge [
        "bind -r h select-pane -L"
        "bind -r j select-pane -D"
        "bind -r k select-pane -U"
        "bind -r l select-pane -R"
        "bind -r H resize-pane -L 5"
        "bind -r J resize-pane -D 5"
        "bind -r K resize-pane -U 5"
        "bind -r L resize-pane -R 5"
        "bind -r M-h resize-pane -L 1"
        "bind -r M-j resize-pane -D 1"
        "bind -r M-k resize-pane -U 1"
        "bind -r M-l resize-pane -R 1"
        ""
        "# urxvt tab like window switching (-n: no prior escape seq)"
        "bind -n S-down new-window"
        "bind -n S-left prev"
        "bind -n S-right next"
        "bind -n C-left swap-window -t -1"
        "bind -n C-right swap-window -t +1"
        ""
        "# Open new panes in current directory"
        ''# bind c new-window -c "#{pane_current_path}"''
        ''bind '"' split-window -c "#{pane_current_path}"''
        ''bind % split-window -h -c "#{pane_current_path}"''
        ''bind | split-window -h -c "#{pane_current_path}"''
        ''bind - split-window -v -c "#{pane_current_path}"''
        ""
        "# Clear Screen because Control+l is taken by vim-tmux-navigator"
        ''bind-key C-l send-keys "C-l"''
      ];
    };
  };
}
