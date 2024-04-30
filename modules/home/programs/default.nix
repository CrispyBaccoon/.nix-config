{ pkgs, lib, ... }: {
  imports = [
    ./neovim
    ./dunst.nix
    ./cava.nix
  ];
}
