{lib, inputs}: let
  # builds system with home manager
  mkSystems = {
    root ? "${inputs.self}/hosts",
    home ? "${inputs.self}/home",
    instances,
  }:
    builtins.listToAttrs (
      map (instance: {
        name = instance.host;
        value = lib.custom.mkSystem {
          hostname = instance.host;
          inherit (instance) system;
          modules = [
            root
            (root + "/${instance.host}")
            home # home manager
          ];
        };
      })
      instances
    );

  mkHomes = {
    root,
    instances,
  } @ args:
    builtins.listToAttrs (
      map (instance: {
        name = instance.user;
        value = lib.custom.mkHome {
          inherit (instance) system;
          modules = [args.root (args.root + "/${instance.user}")];
        };
      })
      args.instances
    );
in {
  inherit mkSystems mkHomes;
}
