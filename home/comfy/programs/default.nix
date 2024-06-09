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
    ./kitty.nix
    ./nvim.nix
    ./zsh.nix
    ./rofi.nix
    ./spotify
    ./vtcol.nix
    ./firefox
    ./obsidian.nix
    ./yazi.nix
    ./discord.nix
    ./izrss.nix
  ];

  home.packages = with pkgs; [
    handlr

    pavucontrol

    nwg-look

    ncmpcpp
    cava
    mpv

    neofetch

    xfce.thunar

    unar
    unzip
    hexyl
    feh

    stow

    gopass
  ];
}
