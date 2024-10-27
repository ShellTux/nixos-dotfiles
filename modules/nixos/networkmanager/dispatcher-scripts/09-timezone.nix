{ pkgs, ... }:
{
  # FIX: This shell script depends on curl
  source = pkgs.writeText "09-timezone" (builtins.readFile ./09-timezone.sh);

  type = "basic";
}
