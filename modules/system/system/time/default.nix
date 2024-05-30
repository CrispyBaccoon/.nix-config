{
  options,
  config,
  lib,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.custom) mkOpt mkOptions;
  cfg = config.system.time;
in {
  options.system.time = mkOptions "configure timezone information" {
    timezone = mkOpt types.str "Europe/Paris" "timezone";
  };

  config = mkIf cfg.enable {time.timeZone = cfg.timezone;};
}
