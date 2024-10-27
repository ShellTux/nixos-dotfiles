{ }:
{
  exec = "uname --kernel-release";
  format = " {}";
  interval = "once";
  exec-if = "exit 0";
  signal = 9;
}
