{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.custom) mkOptions;
  cfg = config.system.audio;
in {
  options.system.audio = mkOptions "enable audio utils" {};

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.alsa-utils];

    hardware.alsa.enablePersistence = true;
  };
}
