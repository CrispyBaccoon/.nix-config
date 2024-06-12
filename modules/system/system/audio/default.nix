{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkForce;
  inherit (lib.custom) mkOptions;
  cfg = config.system.audio;
in {
  options.system.audio = mkOptions "enable audio utils" {};

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.alsa-utils];

    # ALSA provides a udev rule for restoring volume settings.
    services.udev.packages = [pkgs.alsa-utils];

    systemd.services.alsa-store =
      mkForce
      {
        description = "Store Sound Card State";
        wantedBy = ["multi-user.target"];
        unitConfig.RequiresMountsFor = "/var/lib/alsa";
        unitConfig.ConditionVirtualization = "!systemd-nspawn";
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /var/lib/alsa";
          ExecStart = "${pkgs.alsa-utils}/sbin/alsactl restore --ignore";
          ExecStop = "${pkgs.alsa-utils}/sbin/alsactl store --ignore";
        };
      };
  };
}
