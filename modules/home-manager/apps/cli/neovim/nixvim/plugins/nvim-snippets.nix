{ ... }:
{
  programs.nixvim.plugins.nvim-snippets.settings = {
    create_autocmd = true;
    create_cmp_source = true;
    extended_filetypes = {
      typescript = [
        "javascript"
      ];
    };
    friendly_snippets = true;
    global_snippets = [
      "all"
    ];
    ignored_filetypes = [ ];
    search_paths = [
      {
        __raw = "vim.fn.stdpath('config') .. '/snippets'";
      }
    ];
  };
}
