{
  lib,
  inputs,
  config,
  ...
}:
{
  imports = with inputs.home-manager.nixosModules; [
    home-manager
    ./luisgois
    ./user
  ];

  options.users = {
    luisgois.enable = lib.mkEnableOption "Enable luisgois user";
    user.enable = lib.mkEnableOption "Enable user user";
  };

  config.home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      secrets = config.sops.secrets;
    };
  };
}
