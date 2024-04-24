let
  home = import <home-manager-config>;
in
  {
    pkgs,
    inputs,
    lib,
    config,
    ...
  }: {
    imports = [
      ./hyprland.nix
      ./dev.nix
      ./nvim.nix
      ./zsh.nix
      ./rust.nix
      ./rofi.nix
      ./spotify
      ./vtcol.nix
    ];

    home.packages = with pkgs; [
      yazi

      pavucontrol

      nwg-look

      ncmpcpp
      cava
      mpv

      neofetch

      xfce.thunar

      unar
      unzip

      discord
      obsidian

      gthumb # image editor

      gopass
    ];
  }
