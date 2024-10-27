{ lib, config, ... }:
let
  cfg = config.apps.gui.zathura;
in
{
  options.apps.gui.zathura = {
    enable = lib.mkEnableOption "Enable zathura module";

    defaultApplication = {
      enable = lib.mkOption {
        description = "MIME default application configuration";
        type = lib.types.bool;
        default = true;
      };

      mimeTypes = lib.mkOption {
        description = "MIME types to be the default application for";
        type = lib.types.listOf lib.types.str;
        default = [
          "application/illustrator"
          "application/oxps"
          "application/pdf"
          "application/postscript"
          "application/vnd.comicbook+zip"
          "application/vnd.comicbook-rar"
          "application/vnd.ms-xpsdocument"
          "application/x-bzdvi"
          "application/x-bzpdf"
          "application/x-bzpostscript"
          "application/x-cb7"
          "application/x-cbr"
          "application/x-cbt"
          "application/x-cbz"
          "application/x-dvi"
          "application/x-ext-cb7"
          "application/x-ext-cbr"
          "application/x-ext-cbt"
          "application/x-ext-cbz"
          "application/x-ext-djv"
          "application/x-ext-djvu"
          "application/x-ext-dvi"
          "application/x-ext-eps"
          "application/x-ext-pdf"
          "application/x-ext-ps"
          "application/x-gzdvi"
          "application/x-gzpdf"
          "application/x-gzpostscript"
          "application/x-xzpdf"
          "image/vnd.djvu+multipage"
          "image/x-bzeps"
          "image/x-eps"
          "image/x-gzeps"
        ];
      };
    };
  };

  config = lib.mkIf config.apps.gui.zathura.enable {
    programs.zathura = {
      enable = true;

      options = {
        guioptions = "sv";
        adjust-open = "width";
        recolor = true;
        selection-clipboard = "clipboard";
        window-title-basename = true;
        incremental-search = true;
      };

      mappings = {
        j = "navigate next";
        k = "navigate previous";
        "<S-j>" = "scroll down 10";
        "<S-k>" = "scroll up 10";
        h = "scroll down 10";
        l = "scroll up 10";
      };
    };

    xdg.mimeApps.defaultApplications = lib.mkIf cfg.defaultApplication.enable (
      lib.genAttrs cfg.defaultApplication.mimeTypes (_: "org.pwmt.zathura.desktop")
    );
  };
}
