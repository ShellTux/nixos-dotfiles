{}:
[ 
{
	action = "<cmd>make<CR>";
	key = "<C-m>";
	options = {
		silent = true;
		desc = "make";
	};
}
{
	action = "<cmd>vertical resize -2<cr>";
	key = "<Left>";
	options = {
		silent = true;
		desc = "";
	};
}
{
	action = "<cmd>vertical resize +2<cr>";
	key = "<Right>";
	options = {
		silent = true;
		desc = "";
	};
}
{
	action = "<cmd>resize -2<cr>";
	key = "<up>";
	options = {
		silent = true;
		desc = "";
	};
}
{
	action = "<cmd>resize +2<cr>";
	key = "<down>";
	options = {
		silent = true;
		desc = "";
	};
}
{
	action = "<cmd>tabmove -1<cr>";
	key = "<C-S-PageDown>";
}
{
	action = "<cmd>tabmove +1<cr>";
	key = "<C-S-PageUp>";
}
{
	action = "<cmd>nohlsearch<cr>";
	key = "<leader>h";
}
{
	action = "<gv";
	key = "<";
	mode = "v";
}
{
	action = ">gv";
	key = ">";
	mode = "v";
}
{
	action = "<Esc>";
	key = "jj";
	mode = "i";
}
# TODO: Toggle this keybind according to chadtree
{
	action = "<cmd>CHADopen<cr>";
	key = "<leader>pv";
	options = {
		desc = "CHADTree Open";
	};
}
]
