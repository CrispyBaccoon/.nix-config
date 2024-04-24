{
  home,
  lib,
  pkgs,
  config,
  ...
}: {
  systemd.user.services = {
    cliphist = lib.custom.mkGraphicalService {
      Unit.Description = "Clipboard history service";
      Service = {
        ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${lib.getExe pkgs.cliphist} store";
        Restart = "always";
      };
    };
  };
  systemd.user.services = {
    dunst = lib.custom.mkGraphicalService {
      Unit.Description = "notification daemon";
      Service = {
        ExecStart = "${pkgs.dunst}/bin/dunst";
        Restart = "always";
      };
    };
  };
  systemd.user.services = {
    swww = lib.custom.mkGraphicalService {
      Unit.Description = "Wallpaper Daemon";
      Service = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        # Restart = "always";
      };
    };
    wallctl = lib.custom.mkGraphicalService {
      Unit.Description = "Wallpaper cli";
      Unit.Path = [pkgs.bash];
      Service = {
        ExecStart = "${config.home.homeDirectory}/.local/share/wallctl/.wallpaperset";
        Restart = "never";
        RemainAfterExit = true;
        Type = "oneshot";
      };
    };
  };
  systemd.user.services = {
    wlsunset = lib.custom.mkGraphicalService {
      Unit.Description = "";
      Service = {
        ExecStart = "${pkgs.wlsunset}/bin/wlsunset -t 5200 -S 09:00 -s 16:30";
        Restart = "always";
      };
    };
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
