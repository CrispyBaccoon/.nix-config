{ self, inputs, self', inputs', ... }: {
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
