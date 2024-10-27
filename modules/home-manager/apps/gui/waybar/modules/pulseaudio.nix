{ pkgs }:
{
  format = "{volume}% {icon} {format_source}";
  format-bluetooth = "{volume}% {icon} {format_source}";
  format-bluetooth-muted = " {icon} {format_source}";
  format-muted = " {format_source}";
  format-source = "{volume}% ";
  format-source-muted = "";
  format-icons = {
    headphone = "";
    hands-free = "";
    headset = "";
    phone = "";
    portable = "";
    car = "";
    default = [
      ""
      ""
      ""
    ];
  };
  on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
  on-click-right = "${pkgs.qpwgraph}/bin/qpwgraph";
}
