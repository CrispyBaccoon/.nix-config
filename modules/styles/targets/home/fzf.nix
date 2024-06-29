{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.styles.targets.fzf;
in {
  options.styles.targets.fzf.enable = mkBoolOpt config.programs.fzf.enable "fzf theme";

  config = mkIf (config.styles.enable && cfg.enable) {
    programs.fzf.colors = let
      inherit (config) palette;
    in {
      "bg" = "-1";
      "bg+" = "#${palette.surface0}";
      "border" = "0";
      "fg" = "#${palette.overlay1}";
      "fg+" = "#${palette.subtext1}";
      "header" = "#${palette.aqua}";
      "hl" = "#${palette.aqua}";
      "hl+" = "#${palette.subtext1}";
      "info" = "#${palette.blue}";
      "label" = "-1";
      "marker" = "#${palette.pink}";
      "pointer" = "#${palette.pink}";
      "prompt" = "#${palette.yellow}";
      "query" = "-1";
      "spinner" = "#${palette.aqua}";
    };
  };
}
