{}:
{
	enable = true;

	settings = {
		enabled = true;

		cloak_character = "*";
		highlight_group = "Comment";
		patterns = [
		{
			cloak_pattern = "=.+";
			file_pattern = [
				".env*"
					"wrangler.toml"
					".dev.vars"
			];
		}
		];
	};

}
