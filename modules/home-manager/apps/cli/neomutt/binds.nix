{ ... }:
{
	programs.neomutt.binds = [
	{
		key = "<Tab>";
		map = [ "editor" ];
		action = "complete-query";
	}
	{
		key = "\\Ct";
		map = [ "editor" ];
		action = "complete";
	}
	{
		key = "\\\\";
		map = [ "index" "pager" ];
		action = "sidebar-toggle-visible";
	}
	{
		key = "R";
		map = [ "index" "pager" ];
		action = "group-reply";
	}
	{
		key = "B";
		map = [ "index" ];
		action = "toggle-new";
	}
	{
		key = "Z";
		map = [ "index" "pager" ];
		action = "view-raw-message";
	}
	];
}
