{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.nix;
in {
  options.system.nix = with types; {
    enable = mkBoolOpt true "manage nix configuration";
    package = mkOpt package pkgs.nixUnstable "nix package to use";
    extraUsers = mkOpt (listOf str) [] "extra trusted users";
    enableGarbageCollection = mkBoolOpt false "enable automatic garbage collection";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nil
      nixfmt
      nix-index
      nix-prefetch-git
    ];

    nix = let
      users = ["root" config.user.name];
    in {
      inherit (cfg) package;

      settings =
        {
          experimental-features = "nix-command flakes";
          http-connections = 50;
          warn-dirty = false;
          log-lines = 50;
          sandbox = "relaxed";
          auto-optimise-store = true;
          trusted-users = users ++ cfg.extraUsers;
          allowed-users = users;
        };

      gc = mkIf cfg.enableGarbageCollection {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      # flake-utils-plus
      # generateRegistryFromInputs = true;
      # generateNixPathFromInputs = true;
      # linkInputs = true;
    };
  };
}
