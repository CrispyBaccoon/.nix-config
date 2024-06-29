{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  palette = config.palette;
  cfg = config.styles.targets.izrss;
in {
  options.styles.targets.izrss.enable = mkBoolOpt config.programs.izrss.enable "izrss theme";

  config = mkIf (config.styles.enable && cfg.enable) {
    programs.izrss.settings = {
      colors = {
        text = "#${palette.text}";
        inverttext = "#${palette.base}";
        subtext = "#${palette.overlay2}";
        accent = "#${palette.green}";
        borders = "#${palette.surface1}";
      };
    };
  };
}
