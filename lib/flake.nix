let
  mkSystems' = {
    lib,
    root,
    modules,
    instances,
  } @ args:
    builtins.listToAttrs (
      map (instance: {
        name = instance.host;
        value = lib.custom.mkSystem {
          inherit lib;
          hostname = instance.host;
          inherit (instance) system;
          flakeModule = args.modules;
          modules = [args.root (args.root + "/${instance.host}")];
        };
      })
      args.instances
    );

  mkHomes' = {
    lib,
    root,
    modules,
    instances,
  } @ args:
    builtins.listToAttrs (
      map (instance: {
        name = instance.user;
        value = lib.custom.mkHome {
          inherit lib;
          inherit (instance) system;
          flakeModule = args.modules;
          modules = [args.root (args.root + "/${instance.user}")];
        };
      })
      args.instances
    );

  mkFlake = {
    lib,
    home,
    system,
    outputs,
  } @ args:
    {
      # modules
      nixosModules = args.system.modules;
      homeManagerModules = args.home.modules;
      # configurations
      nixosConfigurations = mkSystems' {
        inherit (args) lib;
        inherit (args.system) root modules instances;
      };
      homeConfigurations = mkHomes' {
        inherit (args) lib;
        inherit (args.home) root modules instances;
      };
    }
    // args.outputs;
in {
  inherit mkSystems' mkHomes' mkFlake;
}
