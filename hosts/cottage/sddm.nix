{
  pkgs,
  self,
  ...
}: {
  services.xserver.enable = true;
  services.xserver.displayManager = {
    sddm.enable = true;
    sddm.theme = "sddm-sugar-dark";
  };
  environment.systemPackages = [self.packages.${pkgs.system}.sddm-sugar-dark];
}
