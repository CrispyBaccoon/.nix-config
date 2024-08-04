{
  lib,
  inputs,
  ...
}: let
  custom = lib.makeExtensible (
    self: let
      lib = self;
      flake = import ./flake.nix {inherit lib;};
      builders = import ./builders.nix {inherit lib inputs;};
      services = import ./services.nix {inherit lib;};
      umport = import ./umport.nix {inherit lib;};
      opt = import ./opt.nix {inherit lib;};
      cfg = import ./cfg.nix {inherit lib;};
      theme = import ./theme.nix {inherit lib;};
    in {
      custom = flake // builders // services // umport // opt // cfg // theme;
    }
  );

  ext = lib.fixedPoints.composeManyExtensions [
    (_: _: lib)
  ];
in
  custom.extend ext
