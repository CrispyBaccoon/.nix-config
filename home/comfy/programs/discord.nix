{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # (discord.override {
    #   withVencord = true;
    #   withTTS = true;
    # })
    vesktop
  ];

  systemd.user.services.aarpc = {
    Unit = {
      Description = "discord rich presence for browsers, and some custom clients";
      PartOf = ["graphical-session.target"];
    };

    Service = {
      ExecStart = lib.getExe pkgs.arrpc;
      Restart = "always";
    };

    Install.WantedBy = ["graphical-session.target"];
  };

  systemd.user.services.vesktop = {
    Unit = {
      Description = "vesktop client auto-startup";
      PartOf = ["graphical-session.target"];
    };

    Service = {
      ExecStart = lib.getExe pkgs.vesktop;
      Restart = "never";
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
