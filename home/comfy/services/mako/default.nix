{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.mako];

  services.mako = let
    colors = config.colorScheme.colors;
  in {
    enable = false;

    backgroundColor = "#${colors.base00}";
    textColor = "#${colors.base0F}";
    borderColor = "#${colors.base0F}";
    padding = "15";
    defaultTimeout = 7000;
    borderSize = 3;
    borderRadius = 10;
    height = 300;
    font = "monospace 15";

    extraConfig = ''
      [urgency=high]
      border-color=#ef9f76
    '';
  };
}
