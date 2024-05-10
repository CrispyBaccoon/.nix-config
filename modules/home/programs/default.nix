{ pkgs, lib, ... }: {
  imports = [
    ./neovim
    ./kitty.nix
    ./dunst.nix
    ./cava.nix
  ];
}
