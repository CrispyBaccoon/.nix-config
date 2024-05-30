{
  config,
  lib,
  ...
}: let
  inherit (lib.custom) mkEnableOpt;
in {
  options.theme.dunst = mkEnableOpt "dunst theme";
}
