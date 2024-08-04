{lib}: let
  mkSystems' = {
    root,
    modules,
    instances,
  } @ args:
    builtins.listToAttrs (
      map (instance: {
        name = instance.host;
        value = lib.custom.mkSystem {
          hostname = instance.host;
          inherit (instance) system;
          flakeModule = args.modules;
          modules = [args.root (args.root + "/${instance.host}")];
        };
      })
      args.instances
    );

  mkHomes' = {
    root,
    modules,
    instances,
  } @ args:
    builtins.listToAttrs (
      map (instance: {
        name = instance.user;
        value = lib.custom.mkHome {
          inherit (instance) system;
          flakeModule = args.modules;
          modules = [args.root (args.root + "/${instance.user}")];
        };
      })
      args.instances
    );

  mkFlake = {
    home,
    system,
    outputs,
  } @ args:
    {
      # modules
      nixosModules.default = args.system.modules;
      homeManagerModules.default = args.home.modules;
      # configurations
      nixosConfigurations = mkSystems' {
        inherit (args.system) root modules instances;
      };
      homeConfigurations = mkHomes' {
        inherit (args.home) root modules instances;
      };
    }
    // args.outputs;
in {
  inherit mkSystems' mkHomes' mkFlake;
}
