{inputs, ...}: let
  lib0 = inputs.nixpkgs.lib;

  custom = lib0.fixedPoints.makeExtensible (
    self: let
      lib = self;
      flake = import ./flake.nix {inherit lib inputs;};
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
    (_: _: inputs.home-manager.lib)
  ];
in
  custom.extend ext
