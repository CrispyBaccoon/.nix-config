{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.boot.bios;
in {
  options.system.boot.bios = with types; {
    enable = mkBoolOpt false "enable bios booting";
    device = mkOpt str "/dev/sda" "disk that grub will be installed to";
  };

  config = mkIf cfg.enable {
    boot.loader.grub = {
      enable = true;
      device = "/dev/sda";
    };
  };
}
