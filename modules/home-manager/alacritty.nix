{ lib, config, ... }:
{
	options = {
		alacritty.enable = lib.mkEnableOption "Enable alacritty module";
	};

	config = lib.mkIf config.alacritty.enable {
		programs.alacritty = {
			enable = true;

			settings = {
				window.dimensions = {
					lines = 3;
					columns = 200;
				};
				keyboard.bindings = [
				{
					key = "Return";
					mods = "Control|Shift";
					action = "SpawnNewInstance";
				}
				{
					key = "Plus";
					mods = "Control";
					action = "IncreaseFontSize";
				}
				{
					key = "NumpadAdd";
					mods = "Control";
					action = "IncreaseFontSize";
				}
				{
					key = "Minus";
					mods = "Control";
					action = "DecreaseFontSize";
				}
				{
					key = "NumpadSubtract";
					mods = "Control";
					action = "DecreaseFontSize";
				}
				{
					key = "Key0";
					mods = "Control";
					action = "ResetFontSize";
				}
				];
			};
		};

	};
}
