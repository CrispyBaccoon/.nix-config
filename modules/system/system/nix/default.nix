{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.custom) mkOpt use;
  cfg = config.system.nix;
in {
  options.system.nix = with types; {
    flake = mkOpt path "/home/${config.user.name}/.config/flake" "flake location";
    package = mkOpt package pkgs.nixVersions.git "nix package to use";
    extraUsers = mkOpt (listOf str) [] "extra trusted users";
    enableGarbageCollection =
      mkOpt (enum [
        "gc"
        "nh"
        false
      ])
      false "enable automatic garbage collection";
  };

  config = {
    environment.sessionVariables = {
      FLAKE = cfg.flake;
    };
    environment.systemPackages = with pkgs; [
      nil
      nix-index
      nix-prefetch-git

      nh
      home-manager
    ];

    nix = let
      users = [
        "root"
        config.user.name
      ];
    in {
      inherit (cfg) package;

      # This will add each flake input as a registry
      # To make nix3 commands consistent with your flake
      registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

      # This will additionally add your inputs to the system's legacy channels
      # Making legacy nix commands consistent as well, awesome!
      nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

      settings = {
        experimental-features = "nix-command flakes";
        use-xdg-base-directories = true;
        http-connections = 50;
        warn-dirty = false;
        log-lines = 50;
        sandbox = "relaxed";
        auto-optimise-store = true;
        trusted-users = users ++ cfg.extraUsers;
        allowed-users = users;
      };

      gc = mkIf (cfg.enableGarbageCollection == "gc") {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      # flake-utils-plus
      # generateRegistryFromInputs = true;
      # generateNixPathFromInputs = true;
      # linkInputs = true;
    };

    programs.nh = use {
      clean.enable = mkIf (cfg.enableGarbageCollection == "nh") true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = cfg.flake;
    };
  };
}
