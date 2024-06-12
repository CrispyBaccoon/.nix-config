{
  config,
  lib,
  ...
}: let
  inherit (lib) types;
  inherit (lib.custom) mkOpt mkOpt';
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
    subtext0 = mkOpt' str null;
    subtext1 = mkOpt' str null;
    surface1 = mkOpt' str null;
    surface0 = mkOpt' str null;
    surface = mkOpt' str null;
    base = mkOpt' str null;
  };

  config = let
    colors = config.colorScheme.palette;
  in {
    colorScheme = themes.${cfg.name};

    palette = rec {
      color0 = "${colors.base00}";
      color8 = "${colors.base01}";
      color1 = "${colors.base08}";
      color9 = "${colors.base08}";
      color2 = "${colors.base0B}";
      color10 = "${colors.base0B}";
      color3 = "${colors.base0A}";
      color11 = "${colors.base0A}";
      color4 = "${colors.base0D}";
      color12 = "${colors.base0D}";
      color5 = "${colors.base0E}";
      color13 = "${colors.base0E}";
      color6 = "${colors.base0C}";
      color14 = "${colors.base0C}";
      color7 = "${colors.base05}";
      color15 = "${colors.base04}";
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
      orange = "${colors.base09}";
      sapphire = "${color12}";
      mauve = "${color13}";
      jade = "${color14}";

      text = colors.base05;
      subtext = colors.base04;
      subtext0 = subtext;
      subtext1 = colors.base03;
      surface1 = colors.base02;
      surface0 = surface;
      surface = colors.base01;
      base = colors.base00;
    };
  };
}
