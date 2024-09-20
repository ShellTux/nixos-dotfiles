{}:
let
	leader = " ";
in
{
	globals = {
		mapleader = leader;
		maplocalleader = leader;
		favorite_colorschemes = [
			"adwaita"
			"carbonfox"
			"catppuccin"
			"darkplus"
			"duskfox"
			"github_dark"
			"gruvbox"
			"kanagawa"
			"kanagawa-dragon"
			"nightfox"
			"nordfox"
			"onedark"
			"terafox"
			"tokyonight"
			"vscode"
		];
	};

	opts = {
		background = "dark";
		encoding = "UTF-8";
		exrc = true;
		hlsearch   = true;
		ignorecase = true;
		incsearch  = true;
		linebreak  = false;
		listchars = "tab:> ,trail:•,nbsp:~";
		# mouse:append('a');
		mouse = "nvia";
		number         = true;
		relativenumber = false;
		scrolloff      = 999;
		sidescrolloff  = 10;
		signcolumn     = "yes";
		smartcase      = true;
		syntax         = "enabled";
		termguicolors  = true;
		wildignore     = "*.o,*.a,__pycache__";
		wildmenu       = true;
		wrap           = false;
	};
}
