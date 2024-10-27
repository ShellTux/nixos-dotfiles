{ ... }:
{
  programs.nixvim.plugins.codeium-vim.settings = {
    filetypes_disabled_by_default = true;
    filetypes = {
      bash = true;
      cpp = true;
      css = true;
      c = true;
      dart = true;
      "." = false;
      gitcommit = false;
      gitrebase = false;
      go = true;
      help = false;
      html = true;
      javascript = true;
      java = true;
      kotlin = true;
      lua = true;
      markdown = true;
      php = true;
      python = true;
      rust = true;
      sh = true;
      swift = true;
      typescript = true;
    };
  };
}
