{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.time;
in {
  options.system.time = mkOptions "configure timezone information" {
    timezone = mkOpt types.str "Europe/Paris" "timezone";
  };

  config = mkIf cfg.enable {time.timeZone = cfg.timezone;};
}
