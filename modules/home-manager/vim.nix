{ pkgs, lib, config, inputs, ... }:
{
	options = {
		vim.enable = lib.mkEnableOption "Enable vim module";
	};

	config = lib.mkIf config.vim.enable {
		programs.vim = {
			enable = true;

			settings = {
				background = "dark";
				ignorecase = true;
				number = true;
				relativenumber = false;
				smartcase = true;
			};

			extraConfig = ''
			" Options {{{
			colorscheme habamax
			set foldenable
			set encoding=UTF-8
			set hlsearch
			set incsearch
			set linebreak
			set scrolloff=999
			set termguicolors
			set wildmenu
			syntax enable
			" }}}

			" Keybindings {{{
			nnoremap <C-h> :nohlsearch<CR>
			nnoremap <Down> :resize +2<CR>
			nnoremap J mzJ`z
			nnoremap <leader>tc :tabclose<CR>
			nnoremap <Left> :vertical resize -2<CR>
			nnoremap <Right> :vertical resize +2<CR>
			nnoremap <Up> :resize -2<CR>
			nnoremap Y yg$
			vnoremap J :m '>+1<CR>gv=gv
			vnoremap K :m '<-2<CR>gv=gv
			" }}}
			'';
		};
	};
}
