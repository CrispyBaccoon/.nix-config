{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.custom) mkOptions;
  cfg = config.system.battery;
in {
  options.system.battery = mkOptions "enable battery optimizations and utils" {};

  config = mkIf cfg.enable {
    # Better scheduling for CPU cycles
    services.system76-scheduler.settings.cfsProfiles.enable = true;

    # Enable TLP (better than gnomes internal power manager)
    services.tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };

    # Enable powertop
    powerManagement.powertop.enable = true;
  };
}
