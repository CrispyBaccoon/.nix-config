{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt mapAttrsToCfg mkBase16;
  inherit (config) palette;
  cfg = config.styles.targets.kitty;
in {
  options.styles.targets.kitty.enable = mkBoolOpt config.programs.kitty.enable "kitty theme";

  config = mkIf (config.styles.enable && cfg.enable) {
    apps.kitty.include = let
      base16 =
        mkBase16 (i: v: {
          name = "color${toString i}";
          value = "#${v}";
        })
        palette;
    in [
      (builtins.toFile "kitty-theme-${config.theme.name}" (''
          foreground #${palette.text}
          background #${palette.mantle}
          cursor #${palette.text}
        ''
        + mapAttrsToCfg (n: v: ''${n} ${v}'') base16))
    ];
  };
}
