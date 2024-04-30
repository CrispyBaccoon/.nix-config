{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; {
  options.theme.cava = mkEnableOpt "cava theme";
}
