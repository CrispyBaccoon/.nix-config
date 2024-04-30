{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.fonts;
in {
  options.system.fonts = with types; {
    enable = mkBoolOpt false "manage fonts";
    fonts = mkOpt (listOf package) [] "custom font packages";
    nerdfonts = mkOpt (listOf str) [] "custom nerdfonts";
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
        noto-fonts-emoji
        (nerdfonts.override {fonts = cfg.nerdfonts;})
      ]
      ++ cfg.fonts;
  };
}
