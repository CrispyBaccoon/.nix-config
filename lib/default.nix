{
  lib,
  inputs,
  ...
}: let
  flake = import ./flake.nix {inherit lib;};
  builders = import ./builders.nix {inherit lib inputs;};
  services = import ./services.nix {inherit lib;};
  umport = import ./umport.nix {inherit lib;};
  opt = import ./opt.nix {inherit lib;};
  cfg = import ./cfg.nix {inherit lib;};
  theme = import ./theme.nix {inherit lib;};

  custom = lib.makeExtensible (
    self: {
      custom = flake // builders // services // umport // opt // cfg // theme;
    }
  );
in
  custom.extend (_: _: lib // inputs.home-manager.lib)
