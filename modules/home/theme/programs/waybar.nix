{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  palette = config.palette;
  cfg = {enable = config.theme.waybar;};
in {
  options.theme.waybar = mkEnableOpt "waybar theme";

  config = mkIf cfg.enable {
    home.file.".config/waybar/themes/nix.css" = use {
      text = ''
        @define-color bar-bg rgba(0, 0, 0, 0);

        @define-color main-color #${palette.subtext};
        @define-color main-bg #${palette.background};

        @define-color tool-bg #${palette.background};
        @define-color tool-color #${palette.subtext};
        @define-color tool-border #${palette.green};

        @define-color wb-color #${palette.green};

        @define-color wb-act-bg #${palette.green};
        @define-color wb-act-color #${palette.surface};

        @define-color wb-hvr-bg #${palette.green};
        @define-color wb-hvr-color #${palette.surface};
      '';
    };
  };
}
