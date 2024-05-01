{ pkgs, lib, ... }: {
  imports = [
    ./xdg.nix
    ./gtk.nix
  ];
}
