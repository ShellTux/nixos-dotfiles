{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  imports = with inputs.nixvim.homeManagerModules; [
    nixvim
    ./nixvim
    ./neovim
  ];

  options.apps.cli.neovim = {
    enable = lib.mkEnableOption "Enable neovim module";
    nixvim.enable = lib.mkEnableOption "Enable neovim configuration through nixvim" // {
      default = true;
    };
  };

  config = lib.mkIf config.apps.cli.neovim.enable {
    programs.nixvim.enable = config.apps.cli.neovim.nixvim.enable;
    programs.neovim.enable = (config.apps.cli.neovim.nixvim.enable == false);
  };
}
