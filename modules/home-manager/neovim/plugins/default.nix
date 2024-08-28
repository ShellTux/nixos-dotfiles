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
	rustaceanvim = import ./rustaceanvim.nix { };
	telescope = import ./telescope.nix { };
in
{
	nixvim = {
		inherit
			bufferline
			cloak
			cmp
			codeium-vim
			codesnap
			gitsigns
			indent-blankline
			lastplace
			lsp
			luasnip
			nvim-snippets
			rustaceanvim
			telescope
			;

		auto-save.enable = true;
		chadtree.enable = true;
		friendly-snippets.enable = true;
		fugitive.enable = true;
		lsp-format.enable = true;
		lualine.enable = true;
		markdown-preview.enable = true;
		noice.enable = true;
		notify.enable = true;
		nvim-autopairs.enable = true;
		surround.enable = true;
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
