{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.custom) disabled mkEnableOpt;
  inherit (config) palette;
  cfg = {
    enable = config.theme.kitty;
  };
in {
  options.theme.kitty = mkEnableOpt "kitty theme";

  config = mkIf cfg.enable {
    stylix.targets.kitty = disabled;
    apps.kitty.include = [
      (builtins.toFile "kitty-theme-${config.theme.name}" ''
        foreground = "#${palette.foreground}";
        background = "#${palette.background}";
        cursorColor = "#${palette.foreground}";
        cursor = "#${palette.foreground}";
        color0 = "#${palette.background}";
        color8 = "#${palette.color8}";
        color1 = "#${palette.color1}";
        color9 = "#${palette.color9}";
        color2 = "#${palette.color2}";
        color10 = "#${palette.color10}";
        color3 = "#${palette.color3}";
        color11 = "#${palette.orange}";
        color4 = "#${palette.color4}";
        color12 = "#${palette.color12}";
        color5 = "#${palette.color5}";
        color13 = "#${palette.color13}";
        color6 = "#${palette.color6}";
        color14 = "#${palette.color14}";
        color7 = "#${palette.foreground}";
        color15 = "#${palette.color15}";
      '')
    ];
  };
}
