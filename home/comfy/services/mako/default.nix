{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.mako];

  services.mako = let
    inherit (config) palette;
  in {
    enable = false;

    backgroundColor = "#${palette.base}";
    textColor = "#${palette.text}";
    borderColor = "#${palette.overlay2}";
    padding = "15";
    defaultTimeout = 7000;
    borderSize = 3;
    borderRadius = 10;
    height = 300;
    font = "monospace 15";

    extraConfig = ''
      [urgency=high]
      border-color=#${palette.red}
    '';
  };
}
