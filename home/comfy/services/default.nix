{
  home,
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./sound.nix
    ./hyprland.nix
    ./dunst
  ];

  # services.vtcol = {
  #   enable = true;
  #   settings = {
  #     colorscheme= config.colorScheme.name;
  #   };
  # };
}
