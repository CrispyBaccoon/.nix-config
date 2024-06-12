{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.custom) enabled mkOpt mkBoolOpt;
  cfg = config.system.fonts;
in {
  options.system.fonts = with types; {
    enable = mkBoolOpt false "manage fonts";
    fonts = mkOpt (listOf package) [] "custom font packages";
    nerdfonts = mkOpt (nullOr (listOf str)) null "custom nerdfonts";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      # enable icons in tooling since nerdfonts is installed.
      LOG_ICONS = "true";
    };

    environment.systemPackages = with pkgs; [font-manager];

    fonts.fontconfig = enabled;
    fonts.packages = with pkgs;
      [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        # previously noto-fonts-emoji but that package doesn't actually exist
        # its just an alais to noto-fonts-color-emoji
        noto-fonts-color-emoji
      ]
      ++ (
        if cfg.nerdfonts != null
        then (nerdfonts.override {fonts = cfg.nerdfonts;})
        else []
      )
      ++ cfg.fonts;
  };
}
