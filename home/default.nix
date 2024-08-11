{ self, inputs, ... }: {
  imports = [
    self.homeManagerModules.default
  ];

  palette = inputs.evergarden.palette;

  # Enable home-manager and git
  programs.home-manager.enable = true;
}
