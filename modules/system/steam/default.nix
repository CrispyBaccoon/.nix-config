{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.custom) mkEnableOpt;
  cfg = config.apps.steam;
in {
  options.apps.steam = {
    enable = mkEnableOpt "steam";
    settings = {};
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    environment = {
      systemPackages = with pkgs; [protonup];

      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      };
    };
  };
}
