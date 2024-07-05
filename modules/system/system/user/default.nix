{
  config,
  lib,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.custom) mkOpt mkEnableOpt;
  cfg = config.user;
in {
  options.user = with types; {
    name = mkOpt str "user" "your username";
    initialPassword = mkOpt str "" "initial password when the user is first created";
    extraGroups = mkOpt (listOf str) [] "groups assigned to the user";
    extraOptions = mkOpt attrs {} "extra options passed to <option>users.users.<name></option>.";
    enableAutologin = mkEnableOpt ''autologin
    Whether to enable passwordless login. This is generally useful on systems with
    FDE (Full Disk Encryption) enabled. It is a security risk for systems without FDE.
  '';
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
          [
            "wheel"
            "audio"
            "sound"
            "video"
            "networkmanager"
            "input"
            "tty"
            "docker"
          ]
          ++ cfg.extraGroups;
      }
      // cfg.extraOptions;
  };
}
