<h1 align="center">
    <img src="https://github.com/NixOS/nixos-artwork/blob/master/logo/nix-snowflake-colours.svg" width="100px" />
    <br>
        nixdots
    <br>
</h1>

### :books: structure

- [flake.nix](flake.nix) base of the configuration
- [hosts](hosts) :evergreen_tree: per-host configurations that contain machine specific configurations
  - [hosts/default](hosts/default.nix) default host module for general configuration
  - [cottage](hosts/cottage/) :laptop: specific configuration for my personal machine
- [home](home/) user-specific environment configuration
- [lib](lib/) modularized configurations
  - [nixos](modules/nixos/) core nixos configuration
  - [home-manager](modules/home-manager/) :house: my [home-manager](https://github.com/nix-community/home-manager) config
- [pkgs](pkgs/) packages exported by my flake

