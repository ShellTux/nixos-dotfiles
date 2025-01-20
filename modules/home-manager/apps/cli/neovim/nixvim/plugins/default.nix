{ ... }:
{
  imports = [
    ./auto-save.nix
    ./bufferline.nix
    ./chadtree.nix
    ./cloak.nix
    ./cmp.nix
    ./codeium-vim.nix
    ./codesnap.nix
    ./colorizer.nix
    ./gitsigns.nix
    ./indent-blankline.nix
    ./lastplace.nix
    ./lsp.nix
    ./lualine.nix
    ./luasnip.nix
    ./noice.nix
    ./notify.nix
    ./nvim-snippets.nix
    ./rustaceanvim.nix
    ./screenkey.nix
    ./telescope.nix
  ];

  config.programs.nixvim.plugins = {
    auto-save.enable = true;
    bufferline.enable = true;
    chadtree.enable = true;
    cloak.enable = true;
    colorizer.enable = true;
    cmp.enable = true;
    codeium-vim.enable = true;
    codesnap.enable = true;
    friendly-snippets.enable = true;
    fugitive.enable = true;
    gitsigns.enable = true;
    indent-blankline.enable = true;
    lastplace.enable = true;
    lsp.enable = true;
    lsp-format.enable = true;
    lualine.enable = true;
    luasnip.enable = true;
    markdown-preview.enable = true;
    noice.enable = true;
    nvim-autopairs.enable = true;
    nvim-snippets.enable = true;
    # rustaceanvim.enable = true;
    screenkey.enable = true;
    telescope.enable = true;
    tmux-navigator.enable = true;
    todo-comments.enable = true;
    transparent.enable = true;
    treesitter.enable = true;
    twilight.enable = true;
    undotree.enable = true;
    vim-surround.enable = true;
    vimtex.enable = true;
    which-key.enable = true;
  };
}
