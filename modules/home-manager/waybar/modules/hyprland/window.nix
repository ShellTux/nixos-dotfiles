{}:
{
	format = "{title}";
	rewrite = {
		"(.*) — Mozilla Firefox" = "$1";
		"( )?(.*) - n?vim" = "$2  $1";
		"^n?vim$" = "";
	};
	separate-outputs = true;
	max-length = 50;
	icon = true;
}
