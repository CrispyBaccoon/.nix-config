{
  inputs',
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.custom) use;
  cfg = config.apps.hyprland;
in {
  config = mkIf cfg.enable {
    services = {
      cliphist = use {};

      wlsunset = use {
        temperature.night = 5200;
        sunrise = "07:00";
        sunset = "18:00";
      };
    };

    systemd.user.services = {
      swww = lib.custom.mkGraphicalService {
        Unit.Description = "Wallpaper Daemon";
        Service = {
          ExecStart = "${pkgs.swww}/bin/swww-daemon";
          Restart = "always";
        };
      };

      wallctl = lib.custom.mkGraphicalService {
        Unit.Description = "wallpaper selection";
        Service = {
          ExecStart = "${inputs'.haikei.packages.haikei}/bin/haikei set";
          Restart = "never";
          RemainAfterExit = true;
          Type = "oneshot";
        };
      };

      batterynotify = lib.custom.mkGraphicalService {
        Unit.Description = "battery notifications";
        Service = {
          ExecStart = "${inputs'.hyprflare.packages.batterynotify}/bin/batterynotify";
          Restart = "always";
        };
      };

      libinput-gestures = lib.custom.mkGraphicalService {
        Unit.Description = "Touchpad gestures for wayland";
        Service = {
          ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures -c ${config.xdg.configHome}/hypr/libinput-gestures.conf";
          Restart = "always";
        };
      };
    };
  };
}
