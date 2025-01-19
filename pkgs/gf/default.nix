{ pkgs, ... }:
pkgs.gf.overrideAttrs (
  { patches, ... }:
  {
    patches = patches ++ [ ./gf-hyprland.patch ];
  }
)
