{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.cava;
  enableTheme = config.theme.cava;
  palette = config.palette;
in {
  options.apps.cava = with types; {
    enable = mkBoolOpt false "enable cava";
    extraConfig = mkOpt' str null;
    settings = {
      bar_width = mkOpt' int 2;
      bar_spacing = mkOpt' int 0;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.cava
    ];
    home.file.".config/cava/config" = use {
      text =
        ''
          [general]
          bar_width = ${toString cfg.settings.bar_width}
          bar_spacing = ${toString cfg.settings.bar_spacing}
        ''
        + (if enableTheme then ''
          [color]
          gradient = 1
          gradient_count = 6
          gradient_color_1 = '#${palette.color6}'
          gradient_color_2 = '#${palette.color2}'
          gradient_color_3 = '#${palette.color2}'
          gradient_color_4 = '#${palette.color3}'
          gradient_color_5 = '#${palette.color3}'
          gradient_color_6 = '#${palette.color7}'
        '' else "")
        + cfg.extraConfig;
    };
  };
}
