{ self, inputs, self', inputs', ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  
  home-manager = {
    verbose = true;
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "bak";

    extraSpecialArgs = {
      inherit
        inputs
        self
        inputs'
        self'
        ;
    };

    users.comfy = ./comfy;
  };
}
