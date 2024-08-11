{ pkgs, lib, ... }:
let
	bufferline = import ./bufferline.nix { };
	cloak = import ./cloak.nix { };
	cmp = import ./cmp.nix { };
	codeium-vim = import ./codeium-vim.nix { inherit lib; };
	codesnap = import ./codesnap.nix { };
	gitsigns = import ./gitsigns.nix { };
	indent-blankline = import ./indent-blankline.nix { };
	lastplace = import ./lastplace.nix { };
	lsp = import ./lsp.nix { };
	luasnip = import ./luasnip.nix { };
	nvim-snippets = import ./nvim-snippets.nix { };
	telescope = import ./telescope.nix { };
in
{
	nixvim = {
		auto-save.enable = true;
		bufferline = bufferline;
		chadtree.enable = true;
		cloak = cloak;
		cmp = cmp;
		codeium-vim = codeium-vim;
		codesnap = codesnap;
		friendly-snippets.enable = true;
		fugitive.enable = true;
		gitsigns = gitsigns;
		indent-blankline = indent-blankline;
		lastplace = lastplace;
		lsp = lsp;
		lsp-format.enable = true;
		lualine.enable = true;
		luasnip = luasnip;
		markdown-preview.enable = true;
		noice.enable = true;
		notify.enable = true;
		nvim-autopairs.enable = true;
		nvim-snippets = nvim-snippets;
		rustaceanvim.enable = true;
		surround.enable = true;
		telescope = telescope;
		tmux-navigator.enable = true;
		todo-comments.enable = true;
		transparent.enable = true;
		treesitter.enable = true;
		twilight.enable = true;
		undotree.enable = true;
		vimtex.enable = true;
		which-key.enable = true;
	};

	neovim = with pkgs.vimPlugins; [
		nvim-tree-lua
		onedark-nvim
		telescope-nvim
		todo-comments-nvim
		tokyonight-nvim
		vim-commentary
		vim-surround
		which-key-nvim
	];
}
