{inputs, ...}: let
  inherit (inputs.nixpkgs) lib;

  services = import ./services.nix {inherit lib;};
  opt = import ./opt.nix {inherit lib;};
in
  # nixpkgs.lib.extend (_: _: builders // services // validators // helpers)
  # lib.extend (self: super: super // { custom = super; })
  # lib.extend (_: _: services // opt)
  lib.extend (_: super:
    {custom = services // opt;}
    // inputs.home-manager.lib
    // super)
