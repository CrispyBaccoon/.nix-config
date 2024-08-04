{self, inputs, pkgs, ...}: {
  imports = [
    self.homeManagerModules.default
  ];

  palette = inputs.evergarden.palette;

  nix = {
    enable = true;
    package = pkgs.lix;
    settings.use-xdg-base-directories = true;
  };

  nixpkgs = {
    overlays = [
      self.outputs.overlays.additions
      self.outputs.overlays.modifications
      self.outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
}
