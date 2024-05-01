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
    ./battery.nix
  ];

  # services.vtcol = {
  #   enable = true;
  #   settings = {
  #     colorscheme= config.colorScheme.name;
  #   };
  # };
}
