{
  lib0,
  inputs,
  ...
}: let
  custom = lib0.makeExtensible (
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

  ext = lib0.fixedPoints.composeManyExtensions [
    (_: _: lib0)
  ];
in
  custom.extend ext
