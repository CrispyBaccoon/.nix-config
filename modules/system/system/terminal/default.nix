{
  options,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.custom) mkOpt mkOptions;
  cfg = config.system.terminal;
in {
  options.system.terminal = mkOptions "manage terminal" {
    package = mkOpt types.str "kitty" "custom terminal package";
    font = mkOpt types.str "JetBrainsMono" "custom terminal font";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      TERMINAL = cfg.package;
    };
    environment.systemPackages = [
      pkgs.${cfg.package}
    ];
  };
}
