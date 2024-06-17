{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./neovim
    ./hyprland
    ./waybar
    ./kitty.nix
    ./dunst.nix
    ./cava.nix
  ];
}
