{ }:
let
  mode = import ./mode.nix { };
  scratchpad = import ./scratchpad.nix { };
  workspaces = import ./workspaces.nix { };
in
{
  mode = mode;
  scratchpad = scratchpad;
  workspaces = workspaces;
}
