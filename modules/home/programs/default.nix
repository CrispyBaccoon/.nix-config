{ pkgs, lib, ... }: {
  imports = [
    ./neovim
    ./cava.nix
  ];
}
