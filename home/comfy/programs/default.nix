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
    ./rust.nix
    ./rofi.nix
    ./spotify
    ./vtcol.nix
    ./obsidian.nix
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

    (discord.override {
      withVencord = true;
      withTTS = true;
    })

    gthumb # image editor

    gopass
  ];
}
