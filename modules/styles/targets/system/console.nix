{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf attrVals;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.styles.targets.console;
in {
  options.styles.targets.console.enable = mkBoolOpt true "kernel console theme";

  config =
    mkIf (config.styles.enable && cfg.enable)
    {
      console.colors = let
        inherit (config) palette;
      in
        attrVals [
          "base"
          "red"
          "green"
          "yellow"
          "blue"
          "pink"
          "aqua"
          "text"
          "surface0"
          "orange"
          "surface1"
          "surface2"
          "overlay1"
          "subtext1"
          "overlay0"
          "overlay2"
        ]
        palette;
    };
}
