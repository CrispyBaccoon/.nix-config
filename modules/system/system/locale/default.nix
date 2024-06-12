{
  config,
  lib,
  ...
}: let
  inherit (lib) types mkIf mkForce;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.system.locale;
in {
  options.system.locale = with types; {
    enable = mkBoolOpt false "manage locale settings";
  };

  config = mkIf cfg.enable {
    i18n.defaultLocale = "en_US.UTF-8";

    console = {keyMap = mkForce "us";};
  };
}
