{
  options,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.custom) mkOpt mkBoolOpt;
  cfg = config.user;
in {
  options.user = with types; {
    name = mkOpt str "user" "your username";
    initialPassword =
      mkOpt str ""
      "initial password when the user is first created";
    extraGroups = mkOpt (listOf str) [] "groups assigned to the user";
    extraOptions =
      mkOpt attrs {}
      "extra options passed to <option>users.users.<name></option>.";
    enableAutologin = mkBoolOpt false "enable autologin";
  };

  config = {
    services.getty.autologinUser = mkIf cfg.enableAutologin cfg.name;

    users.users.${cfg.name} =
      {
        isNormalUser = true;
        inherit (cfg) name initialPassword;
        home = "/home/${cfg.name}";
        group = "users";

        extraGroups =
          ["wheel" "audio" "sound" "video" "networkmanager" "input" "tty" "docker"]
          ++ cfg.extraGroups;
      }
      // cfg.extraOptions;
  };
}
