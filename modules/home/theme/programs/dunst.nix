{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; {
  options.theme.dunst = mkEnableOpt "dunst theme";
}
