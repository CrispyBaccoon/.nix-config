{ self, inputs, self', inputs', ... }: {
  imports = [
    self.homeManagerModules.default
  ];

  palette = inputs.evergarden.palette;

  # Enable home-manager and git
  programs.home-manager.enable = true;

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
