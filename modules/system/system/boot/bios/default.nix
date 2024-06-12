{
  config,
  lib,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.custom) mkOpt mkBoolOpt;
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
