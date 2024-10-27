{ ... }:
{
  programs.nixvim.plugins.cmp.settings = {
    mapping.__raw = ''
      cmp.mapping.preset.insert({
      	['<C-b>'] = cmp.mapping.scroll_docs(-4),
      	['<C-f>'] = cmp.mapping.scroll_docs(4),
      	['<C-Space>'] = cmp.mapping.complete(),
      	['<C-e>'] = cmp.mapping.abort(),
      	['<CR>'] = cmp.mapping.confirm({ select = true }),
      	})
    '';
    snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
    sources = [
      { name = "nvim_lsp"; }
      { name = "vsnip"; }
      { name = "luasnip"; }
      { name = "path"; }
      { name = "buffer"; }
    ];
    # window.__raw = ''
    # 	completion = cmp.config.window.bordered(),
    # 	documentation = cmp.config.window.bordered()
    # '';
  };
}
