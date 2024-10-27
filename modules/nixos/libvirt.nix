{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.libvirt.enable = lib.mkEnableOption "Enable libvirt module";

  config = lib.mkIf config.libvirt.enable {
    virtualisation.libvirtd = {
      enable = true;

      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
      };
    };

    programs.virt-manager.enable = true;
  };
}
