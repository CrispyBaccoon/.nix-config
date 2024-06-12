{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.system.boot.efi;
in {
  options.system.boot.efi = {
    enable = mkBoolOpt false "enable efi booting";
    firstBoot = mkBoolOpt false "installation bootstep";
  };

  config = mkIf cfg.enable {
    boot = {
      bootspec.enable = true;
      lanzaboote = {
        enable = !cfg.firstBoot;
        pkiBundle = "/etc/secureboot";
      };

      loader = {
        systemd-boot.enable = lib.mkForce cfg.firstBoot;

        # https://github.com/NixOS/nixpkgs/blob/c32c39d6f3b1fe6514598fa40ad2cf9ce22c3fb7/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix#L66
        systemd-boot.editor = false;

        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };
      };
    };
  };
}
