{
  config,
  lib,
  ...
}: let
  inherit (lib.custom) mkEnableOpt;
in {
  options.theme.cava = mkEnableOpt "cava theme";
}
