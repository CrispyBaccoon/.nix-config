{
  lib,
  inputs,
}: let
  # inherit self from inputs
  inherit (inputs) self;

  perInput = system: flake:
    lib.optionalAttrs (flake ? formatter.${system}) {
      formatter = flake.formatter.${system};
    }
    // lib.optionalAttrs (flake ? packages.${system}) {
      packages = flake.packages.${system};
    }
    // lib.optionalAttrs (flake ? legacyPackages.${system}) {
      legacyPackages = flake.legacyPackages.${system};
    };

  # withSystem' returns a set:
  #  {
  #   inputs',
  #   self',
  #  }
  withSystem' = system: let
    inputs' =
      lib.mapAttrs (
        inputName: input:
          builtins.addErrorContext
          "while retrieving system-dependent attributes for input ${lib.escapeNixIdentifier inputName}"
          (
            if input._type or null == "flake"
            then perInput system input
            else throw "Trying to retrieve system-dependent attributes for input ${lib.escapeNixIdentifier inputName}, but this input is not a flake. Perhaps flake = false was added to the input declarations by mistake, or you meant to use a different input, or you meant to use plain old inputs, not inputs'."
          )
      )
      self.inputs;
    self' = builtins.addErrorContext "while retrieving system-dependent attributes for a flake's own outputs" (
      perInput system self
    );
  in {
    inherit inputs' self';
  };
  withSystem = system: f: f (withSystem' system);

  # just an alias to nixpkgs.lib.nixosSystem, lets me avoid adding
  # nixpkgs to the scope in the file it is used in
  mkSystem' = lib.nixosSystem;
  mkHome' = inputs.home-manager.lib.homeManagerConfiguration;

  mkSystem = {
    modules,
    system,
    hostname,
  } @ args:
    withSystem system (
      {
        inputs',
        self',
      }:
        mkSystem' {
          modules = let
            systemModules = import (inputs.self + "/modules/system") {
              inherit lib;
              pkgs = inputs.nixpkgs;
            };
          in
            [
              systemModules
              {
                networking.hostName = hostname;
                nixpkgs = {
                  hostPlatform = lib.mkDefault system;
                  flake.source = inputs.nixpkgs.outPath;
                };
              }
            ]
            ++ modules;
          specialArgs =
            {
              inherit
                lib
                inputs
                self
                inputs'
                self'
                ;
            }
            // args.specialArgs or {};
        }
    );

  mkHome = {
    modules,
    system,
  } @ args:
    withSystem system (
      {
        inputs',
        self',
        ...
      }:
        mkHome' {
          modules = modules;
          pkgs = inputs.nixpkgs.legacyPackages.${system};
          inherit lib;
          extraSpecialArgs =
            {
              inherit
                inputs
                self
                inputs'
                self'
                ;
            }
            // args.specialArgs or {};
        }
    );
in {
  inherit mkSystem mkHome;
}
