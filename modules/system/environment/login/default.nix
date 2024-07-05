{lib, ...}: let
  inherit (lib) types;
  inherit (lib.custom) mkOpt mkEnableOpt;
in {
  imports = [
    ./greetd.nix
    ./sddm.nix
  ];

  options.environment.loginManager = mkOpt (types.enum ["greetd" "sddm"]) "greetd" "the login manager to be used by the system.";
}
