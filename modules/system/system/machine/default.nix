{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.machine;
in {
  options.system.machine = {
    enable = mkEnableOpt "machine optimizations and utils";
    type = mkOpt (types.enum ["laptop" "pc"]) "laptop" "enable default optimizations and utils for machine type";
  };

  config =
    mkIf (cfg.enable && (cfg.type == "laptop")) {
      services.logind.extraConfig = ''
        # don’t shutdown when power button is short-pressed, instead suspend
        HandlePowerKey=suspend

        # suspend when lid is closed
        HandleLidSwitch=suspend
        # don't suspend when connected to external power or connected to an external monitor
        HandleLidSwitchExternalPower=ignore
        HandleLidSwitchDocked=ignore
      '';
    }
    // mkIf (cfg.enable && (cfg.type == "pc")) {};
}
