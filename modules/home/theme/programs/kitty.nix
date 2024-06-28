{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.custom) disabled mkEnableOpt mapAttrsToCfg mkBase16;
  inherit (config) palette;
  cfg = {
    enable = config.theme.kitty;
  };
in {
  options.theme.kitty = mkEnableOpt "kitty theme";

  config = mkIf cfg.enable {
    stylix.targets.kitty = disabled;
    apps.kitty.include = let
      base16 =
        mkBase16 (i: v: {
          name = "color${i}";
          value = "#${v}";
        })
        palette;
    in [
      (builtins.toFile "kitty-theme-${config.theme.name}" ''
          foreground = "#${palette.text}";
          background = "#${palette.mantle}";
          cursor = "#${palette.text}";
        ''
        + mapAttrsToCfg (n: v: ''${n} = "${v}";'') base16)
    ];
  };
}
