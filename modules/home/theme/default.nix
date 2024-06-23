{
  config,
  lib,
  ...
}: let
  inherit (lib) types;
  inherit (lib.custom) mkOpt mkOpt';
  cfg = config.theme;
in {
  options.theme = with types; {
    name = mkOpt str "evergarden" "global theme";
  };
  options.palette = with types; {
    red      = mkOpt' str "E67E80";
    orange   = mkOpt' str "E69875";
    yellow   = mkOpt' str "DBBC7F";
    green    = mkOpt' str "B2C98F";
    aqua     = mkOpt' str "93C9A1";
    sky      = mkOpt' str "97C9C3";
    blue     = mkOpt' str "9BB5CF";
    purple   = mkOpt' str "D6A0D1";
    pink     = mkOpt' str "E3A8D1";
    text     = mkOpt' str "D9E4DC";
    subtext1 = mkOpt' str "C9D6D0";
    subtext0 = mkOpt' str "AEC2BE";
    overlay2 = mkOpt' str "99ADAD";
    overlay1 = mkOpt' str "6E8585";
    overlay0 = mkOpt' str "5E6C70";
    surface2 = mkOpt' str "46545B";
    surface1 = mkOpt' str "3D494F";
    surface0 = mkOpt' str "343E44";
    base     = mkOpt' str "252B2E";
    mantle   = mkOpt' str "1C2225";
    crust    = mkOpt' str "171C1F";
  };
}
