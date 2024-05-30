{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.steam;
in {
  options.apps.steam = with types; {
    enable = mkEnableOpt "steam";
    settings = {
    };
  };

  config = mkIf cfg.enable {
    programs.steam = let
      c = cfg.settings;
    in {
      enable = true;
      gamescopeSession.enable = true;
    };
    environment.systemPackages = with pkgs; [
      protonup
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}
