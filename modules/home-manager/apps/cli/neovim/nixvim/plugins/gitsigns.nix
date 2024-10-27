{ ... }:
{
  programs.nixvim.plugins.gitsigns.settings = {
    current_line_blame = false;
    current_line_blame_opts.delay = 1000;
    linehl = false;
    numhl = true;
    signcolumn = true;
    word_diff = false;
  };
}
