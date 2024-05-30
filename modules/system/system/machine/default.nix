{
  options,
  config,
  lib,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.custom) mkOpt mkEnableOpt;
  cfg = config.system.machine;
in {
  options.system.machine = {
    enable = mkEnableOpt "machine optimizations and utils";
    type = mkOpt (types.enum ["laptop" "pc"]) "laptop" "enable default optimizations and utils for machine type";
  };

  config =
    mkIf (cfg.enable && (cfg.type == "laptop")) {
      services.logind = {
        # don’t shutdown when power button is short-pressed, instead suspend
        powerKey = "suspend";
        # suspend when lid is closed
        lidSwitch = "suspend";
        # don't suspend when connected to external power or connected to an external monitor
        lidSwitchExternalPower = "ignore";
        lidSwitchDocked = "ignore";
      };
    }
    // mkIf (cfg.enable && (cfg.type == "pc")) {};
}
