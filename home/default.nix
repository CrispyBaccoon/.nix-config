{
  self,
  self',
  inputs,
  inputs',
  ...
}: {
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
