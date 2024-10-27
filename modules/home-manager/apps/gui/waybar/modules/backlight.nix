{ pkgs }:
{
  format = "{percent}% {icon}";
  format-icons = [
    ""
    ""
    ""
    ""
    ""
    ""
    ""
    ""
    ""
  ];
  on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set +1% --quiet";
  on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 1%- --min-value 1 --quiet";
}
