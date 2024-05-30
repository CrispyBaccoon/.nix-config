{
  home,
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) getExe;
  inherit (lib.custom) use;
in {
  services.cliphist = use {};
  systemd.user.services = {
    waybar = lib.custom.mkGraphicalService {
      Unit.Description = "waybar";
      Service = {
        ExecStart = getExe pkgs.waybar;
        Restart = "on-failure";
      };
    };
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
  };
  services.wlsunset = use {
    temperature = {night = 5200;};
    sunrise = "07:00";
    sunset = "18:00";
  };
  systemd.user.services = {
    batterynotify = lib.custom.mkGraphicalService {
      Unit.Description = "";
      Service = {
        ExecStart = "${pkgs.bash}/bin/bash -c '${config.home.homeDirectory}/.config/hypr/scripts/batterynotify.sh'";
        Restart = "always";
      };
    };
  };
  systemd.user.services = {
    libinput-gestures = lib.custom.mkGraphicalService {
      Unit.Description = "Touchpad gestures for wayland";
      Service = {
        ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures -c ${config.home.homeDirectory}/.config/hypr/libinput-gestures.conf";
        Restart = "always";
      };
    };
  };
}
