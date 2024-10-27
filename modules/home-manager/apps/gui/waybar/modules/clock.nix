{ }:
{
  tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
  format = "{:%H:%M} ";
  format-alt = "{:%I:%M %p} ";
  calendar = {
    mode = "month";
    mode-mon-col = 3;
    weeks-pos = "right";
    on-scroll = 1;
    on-click-right = "mode";
    format = {
      months = "<span color='#ffead3'><b>{}</b></span>";
      days = "<span color='#ecc6d9'><b>{}</b></span>";
      weeks = "<span color='#99ffdd'><b>W{}</b></span>";
      weekdays = "<span color='#ffcc66'><b>{}</b></span>";
      today = "<span color='#ff6699'><b><u>{}</u></b></span>";
    };
  };
}
