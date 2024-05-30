{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.custom) mkEnableOpt;
  palette = config.palette;
  cfg = {enable = config.theme.izrss;};
in {
  options.theme.izrss = mkEnableOpt "izrss theme";

  config = mkIf cfg.enable {
    programs.izrss.settings = {
      colors = {
        text = "#${palette.text}";
        inverttext = "#${palette.base}";
        subtext = "#${palette.subtext}";
        accent = "#${palette.green}";
        borders = "#${palette.surface1}";
      };
    };
  };
}
