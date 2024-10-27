{ pkgs }:
{
  format = "";
  tooltip = false;
  on-click = "sh -c '(sleep 0.3s; ${pkgs.wlogout}/bin/wlogout --protocol layer-shell)' & disown";
}
