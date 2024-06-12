{
  self,
  ...
}: {
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
}
