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
      sensitivity = mkOpt' int 80;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.cava
    ];
    home.file.".config/cava/config" = let
      c = cfg.settings;
    in
      use {
        text =
          ''
            [general]
            bar_width = ${toString c.bar_width}
            bar_spacing = ${toString c.bar_spacing}
            sensitivity = ${toString c.sensitivity}
          ''
          + (
            if enableTheme
            then ''
              [color]
              gradient = 1
              gradient_count = 6
              gradient_color_1 = '#${palette.aqua}'
              gradient_color_2 = '#${palette.green}'
              gradient_color_3 = '#${palette.green}'
              gradient_color_4 = '#${palette.yellow}'
              gradient_color_5 = '#${palette.yellow}'
              gradient_color_6 = '#${palette.orange}'
            ''
            else ""
          )
          + cfg.extraConfig;
      };
  };
}
