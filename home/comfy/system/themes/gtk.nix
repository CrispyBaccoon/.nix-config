{
  self',
  lib,
  pkgs,
  ...
}: {
  gtk = {
    font = lib.mkForce {
      name = "JetBrainsMono NF";
      package = lib.mkForce null;
      size = 11;
    };
    iconTheme = {
      name = "gruvbox-plus";
      package = self'.packages.gruvbox-plus;
    };
  };
  # papirus-icon-theme as fallback
  home.packages = [pkgs.papirus-icon-theme];
}
