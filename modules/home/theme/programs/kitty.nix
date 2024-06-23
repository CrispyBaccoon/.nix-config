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
        foreground = "#${palette.text}";
        background = "#${palette.mantle}";
        cursor = "#${palette.text}";
        color0 = "#${palette.base}";
        color1 = "#${palette.red}";
        color2 = "#${palette.green}";
        color3 = "#${palette.yellow}";
        color4 = "#${palette.blue}";
        color5 = "#${palette.pink}";
        color6 = "#${palette.aqua}";
        color7 = "#${palette.text}";
        color8 = "#${palette.surface0}";
        color9 = "#${palette.orange}";
        color10 = "#${palette.surface1}";
        color11 = "#${palette.surface2}";
        color12 = "#${palette.overlay1}";
        color13 = "#${palette.subtext1}";
        color14 = "#${palette.overlay0}";
        color15 = "#${palette.overlay2}";
      '')
    ];
  };
}
