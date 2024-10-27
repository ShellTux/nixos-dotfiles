{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.gui.nemo = {
    enable = lib.mkEnableOption "Enable nemo module";
    # TODO: add enable options for nemo extensions

    defaultApplication = lib.mkOption {
      description = "Make nemo default application launcher for directories";
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.apps.gui.nemo.enable {
    home.packages = with pkgs; [
      nemo-emblems
      nemo-fileroller
      nemo-with-extensions
    ];

    xdg = {
      configFile."gtk-3.0/bookmarks".text =
        let
          bookmark = name: path: "file://${path} ${name}";
        in
        (lib.mkMerge [
          (bookmark "Documentos" "${config.xdg.userDirs.documents}")
          (bookmark "Imagens" "${config.xdg.userDirs.pictures}")
          (bookmark "Música" "${config.xdg.userDirs.music}")
          (bookmark "Transferências" "${config.xdg.userDirs.download}")
          (bookmark "Vídeos" "${config.xdg.userDirs.videos}")
        ]);

      mimeApps.defaultApplications = lib.mkIf config.apps.gui.nemo.defaultApplication {
        "inode/directory" = "nemo.desktop";
      };
    };
  };
}
