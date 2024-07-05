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
  - [system](modules/system/) core nixos configuration
  - [home](modules/home/) :house: my [home-manager](https://github.com/nix-community/home-manager) config
- [pkgs](pkgs/) packages exported by my flake

## installation

```bash
./rebuild.sh home # to rebuild home-manager
./rebuild.sh system # to rebuild system
./rebuild.sh all # to rebuild both
```

> [!NOTE]
> nixdots can also be installed manually using:
>
> ```bash
> home-manager --flake .#comfy switch # for home-manager
> sudo nixos-rebuild --flake .#cottage switch # for system
> ```
