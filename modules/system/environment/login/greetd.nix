{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (config) system environment user;
  inherit
    (lib)
    mkIf
    getExe
    concatStringsSep
    ;

  sessionData = config.services.displayManager.sessionData.desktops;
  sessionPath = concatStringsSep ":" [
    "${sessionData}/share/xsessions"
    "${sessionData}/share/wayland-sessions"
  ];
in {
  config.services.greetd = {
    enable = environment.loginManager == "greetd";
    vt = 2;
    restart = !user.enableAutologin;

    settings = {
      default_session = {
        user = "greeter";
        command = concatStringsSep " " [
          (getExe pkgs.greetd.tuigreet)
          "--time"
          "--remember"
          "--remember-user-session"
          "--asterisks"
          "--sessions '${sessionPath}'"
        ];
      };

      initial_session = mkIf user.enableAutologin {
        user = "${user.name}";
        command = "${environment.desktop}";
      };
    };
  };
}
