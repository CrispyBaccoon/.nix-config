{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.custom) use;
in {
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
        Restart = "on-failure";
      };
    };

    wallctl = lib.custom.mkGraphicalService {
      Unit.Description = "set wallpaper";
      Service = {
        ExecStart = "${config.home.homeDirectory}/.saku/root/bin/haikei";
        Restart = "never";
        RemainAfterExit = true;
        Type = "oneshot";
      };
    };

    batterynotify = lib.custom.mkGraphicalService {
      Unit.Description = "";
      Service = {
        ExecStart = "${pkgs.bash}/bin/bash -c '${config.xdg.configHome}/hypr/scripts/batterynotify.sh'";
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
}
