{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./colorschemes.nix
    ./keymaps.nix
    ./settings.nix
    ./plugins
  ];

  config.programs.nixvim = {
    clipboard.providers = {
      wl-copy.enable = true;
      xclip.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      render-markdown-nvim
      vim-easy-align
      vim-llvm
    ];

    extraConfigLua =
      let
        extraPlugins = config.programs.nixvim.extraPlugins;
      in
      with pkgs.vimPlugins;
      lib.mkMerge [
        (
          if (lib.elem render-markdown-nvim extraPlugins) then "require('render-markdown').setup({})" else ""
        )
        (
          if (lib.elem vim-easy-align extraPlugins) then
            ''
              -- Start interactive EasyAlign in visual mode (e.g. vipga)
              vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})

              -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
              vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})
            ''
          else
            ""
        )
        (builtins.readFile ./random_colorscheme.lua)

        "vim.cmd[[highlight ExtraWhitespace ctermbg=red guibg=red]]"
      ];
  };
}
