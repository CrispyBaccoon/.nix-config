{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.custom) mkOpt' mkEnableOpt;
  cfg = config.styles;
in {
  options.styles = with types; {
    enable = mkEnableOpt "styles";
    fonts = {
      monospace = {
        package = mkOpt' package (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];});
        name = mkOpt' str "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = mkOpt' package pkgs.dejavu_fonts;
        name = mkOpt' str "DejaVu Sans";
      };
      serif = {
        package = mkOpt' package pkgs.dejavu_fonts;
        name = mkOpt' str "DejaVu Sans";
      };
    };
  };

  config = mkIf cfg.enable {
    stylix = {
      autoEnable = true;
      image = config.lib.stylix.pixel "base0A";
      cursor = {
        package = pkgs.capitaine-cursors;
        name = "capitaine-cursors";
      };
      fonts =
        cfg.fonts
        // {
          sizes = {
            applications = 12;
            terminal = 10;
            desktop = 10;
            popups = 10;
          };
        };
      };
      opacity = {
        applications = 0.92;
        terminal = 0.8;
        desktop = 1.0;
        popups = 1.0;
      };
      base16Scheme = (import ../../home/theme/themes/evergarden.nix).palette;
    };
  };
}
