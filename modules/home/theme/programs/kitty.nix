{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  palette = config.palette;
  cfg = {enable = config.theme.kitty;};
in {
  options.theme.kitty = mkEnableOpt "kitty theme";

  config = mkIf cfg.enable {
    apps.kitty.include = [
      "~/.config/kitty/themes/${config.theme.name}"
    ];
    home.file.".config/kitty/themes/${config.theme.name}" = let
      themeopts = rec {
        foreground = "#${palette.foreground}";
        background = "#${palette.background}";
        cursorColor = foreground;
        cursor = cursorColor;
        color0 = background;
        color8 = "#${palette.color8}";
        color1 = "#${palette.color1}";
        color9 = "#${palette.color9}";
        color2 = "#${palette.color2}";
        color10 = "#${palette.color10}";
        color3 = "#${palette.color3}";
        color11 = "#${palette.color11}";
        color4 = "#${palette.color4}";
        color12 = "#${palette.color12}";
        color5 = "#${palette.color5}";
        color13 = "#${palette.color13}";
        color6 = "#${palette.color6}";
        color14 = "#${palette.color14}";
        color7 = foreground;
        color15 = "#${palette.color15}";
      };
    in {
      enable = true;
      text =
        strings.concatStringsSep "\n"
        (mapAttrsToList (
            key: value:
              strings.concatStringsSep " " [key value]
          )
          themeopts);
    };
  };
}
