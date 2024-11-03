{ config, ... }:
{
  config.programs.nixvim = {
    plugins.codesnap.settings = {
      bg_theme = "bamboo";
      breadcrumbs_separator = "/";
      has_breadcrumbs = true;
      has_line_number = false;
      bg_x_padding = 30;
      bg_y_padding = 20;
      mac_window_bar = true;
      save_path = config.xdg.userDirs.pictures;
      title = "CodeSnap.nvim";
      watermark = "";
    };

    keymaps =
      let
        normalAction = command: "<CMD>1,\$${command}<CR>";
        visualAction = command: "<CMD>${command}<CR>";
      in
      [
        {
          action = normalAction "CodeSnap";
          key = "<leader>cc";
          mode = "n";
          options = {
            silent = true;
            desc = "Save selected code snapshot into clipboard";
          };
        }
        {
          action = normalAction "CodeSnapSave";
          key = "<leader>cs";
          mode = "n";
          options = {
            desc = "Save selected code snapshot in ${config.programs.nixvim.plugins.codesnap.settings.save_path}";
            silent = true;
          };
        }
        {
          action = visualAction "CodeSnap";
          key = "<leader>cc";
          mode = "x";
          options = {
            silent = true;
            desc = "Save selected code snapshot into clipboard";
          };
        }
        {
          action = visualAction "CodeSnapSave";
          key = "<leader>cs";
          mode = "x";
          options = {
            desc = "Save selected code snapshot in ${config.programs.nixvim.plugins.codesnap.settings.save_path}";
            silent = true;
          };
        }
      ];
  };
}
