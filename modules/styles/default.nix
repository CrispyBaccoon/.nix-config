{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.custom) mkOpt mkOpt' mkEnableOpt;
  cfg = config.styles;
in {
  options.styles = with types; {
    enable = mkEnableOpt "styles";
    cursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = mkOpt' int 24;
    };
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
      sizes = {
        applications = mkOpt' int 11;
        terminal = mkOpt' int 10;
        desktop = mkOpt' int 10;
        popups = mkOpt' int 10;
      };
    };
    opacity = {
      applications = mkOpt' float 0.92;
      terminal = mkOpt' float 0.8;
      desktop = mkOpt' float 1.0;
      popups = mkOpt' float 1.0;
    };
  };
  options.theme = with types; {
    name = mkOpt str "evergarden" "global theme";
  };
  options.palette = with types; {
    red = mkOpt' str "E67E80";
    orange = mkOpt' str "E69875";
    yellow = mkOpt' str "DBBC7F";
    green = mkOpt' str "B2C98F";
    aqua = mkOpt' str "93C9A1";
    sky = mkOpt' str "97C9C3";
    blue = mkOpt' str "9BB5CF";
    purple = mkOpt' str "D6A0D1";
    pink = mkOpt' str "E3A8D1";
    text = mkOpt' str "D9E4DC";
    subtext1 = mkOpt' str "C9D6D0";
    subtext0 = mkOpt' str "AEC2BE";
    overlay2 = mkOpt' str "99ADAD";
    overlay1 = mkOpt' str "6E8585";
    overlay0 = mkOpt' str "5E6C70";
    surface2 = mkOpt' str "46545B";
    surface1 = mkOpt' str "3D494F";
    surface0 = mkOpt' str "343E44";
    base = mkOpt' str "252B2E";
    mantle = mkOpt' str "1C2225";
    crust = mkOpt' str "171C1F";
  };

  config =
    mkIf cfg.enable {
    };
}
