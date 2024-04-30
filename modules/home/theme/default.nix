{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  themes = import ./themes;
  cfg = config.theme;
in {
  options.theme = with types; {
    name = mkOpt str "evergarden" "global theme";
  };
  options.palette = with types; {
    color0 = mkOpt' str null;
    color8 = mkOpt' str null;
    color1 = mkOpt' str null;
    color9 = mkOpt' str null;
    color2 = mkOpt' str null;
    color10 = mkOpt' str null;
    color3 = mkOpt' str null;
    color11 = mkOpt' str null;
    color4 = mkOpt' str null;
    color12 = mkOpt' str null;
    color5 = mkOpt' str null;
    color13 = mkOpt' str null;
    color6 = mkOpt' str null;
    color14 = mkOpt' str null;
    color7 = mkOpt' str null;
    color15 = mkOpt' str null;
    foreground = mkOpt' str null;
    background = mkOpt' str null;
    red = mkOpt' str null;
    green = mkOpt' str null;
    yellow = mkOpt' str null;
    blue = mkOpt' str null;
    lavender = mkOpt' str null;
    aqua = mkOpt' str null;
    maroon = mkOpt' str null;
    teal = mkOpt' str null;
    orange = mkOpt' str null;
    sapphire = mkOpt' str null;
    mauve = mkOpt' str null;
    jade = mkOpt' str null;

    text = mkOpt' str null;
    subtext = mkOpt' str null;
    surface = mkOpt' str null;
    base = mkOpt' str null;
  };

  config = {
    colorScheme = themes.${cfg.name};

    palette = rec {
      color0 = "${config.colorScheme.palette.base00}";
      color8 = "${config.colorScheme.palette.base08}";
      color1 = "${config.colorScheme.palette.base01}";
      color9 = "${config.colorScheme.palette.base09}";
      color2 = "${config.colorScheme.palette.base02}";
      color10 = "${config.colorScheme.palette.base0A}";
      color3 = "${config.colorScheme.palette.base03}";
      color11 = "${config.colorScheme.palette.base0B}";
      color4 = "${config.colorScheme.palette.base04}";
      color12 = "${config.colorScheme.palette.base0C}";
      color5 = "${config.colorScheme.palette.base05}";
      color13 = "${config.colorScheme.palette.base0D}";
      color6 = "${config.colorScheme.palette.base06}";
      color14 = "${config.colorScheme.palette.base0E}";
      color7 = "${config.colorScheme.palette.base07}";
      color15 = "${config.colorScheme.palette.base0F}";
      foreground = "${color7}";
      background = "${color0}";
      red = "${color1}";
      green = "${color2}";
      yellow = "${color3}";
      blue = "${color4}";
      lavender = "${color5}";
      aqua = "${color6}";
      maroon = "${color9}";
      teal = "${color10}";
      orange = "${color11}";
      sapphire = "${color12}";
      mauve = "${color13}";
      jade = "${color14}";

      text = "${color7}";
      subtext = "${color15}";
      surface = "${color8}";
      base = "${color0}";
    };
  };
}
