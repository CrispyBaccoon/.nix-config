{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    libratbag
    piper
  ];

  systemd.services."libratbag" = {
    wantedBy = ["multi-user.target"];
    after = ["graphical.target"];
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      ExecStart = lib.mkForce ''
        ${pkgs.libratbag}/bin/ratbagd
      '';
    };
  };
}
