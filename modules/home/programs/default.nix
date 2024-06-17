{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./neovim
    ./hyprland
    ./kitty.nix
    ./dunst.nix
    ./cava.nix
  ];
}
