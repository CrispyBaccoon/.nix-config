{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  inherit (lib.custom) mkOpt mkEnableOpt;

  cfg = config.environment;
in {
  options.environment = {
    desktop =
      mkOpt (types.nullOr (types.enum ["Hyprland" "sway"])) "Hyprland"
      "the desktop environment to be used.";

    isWayland =
      mkEnableOpt "inferred data based on the desktop environment."
      // {
        default = cfg.desktop == "Hyprland" || cfg.desktop == "sway";
      };
  };
}
