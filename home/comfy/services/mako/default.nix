{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.mako];

  services.mako = let
    colors = config.palette;
  in {
    enable = false;

    backgroundColor = "#${colors.base}";
    textColor = "#${colors.foreground}";
    borderColor = "#${colors.subtext}";
    padding = "15";
    defaultTimeout = 7000;
    borderSize = 3;
    borderRadius = 10;
    height = 300;
    font = "monospace 15";

    extraConfig = ''
      [urgency=high]
      border-color=#${colors.red}
    '';
  };
}
