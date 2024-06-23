{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./kitty.nix
    ./nvim.nix
    ./zsh.nix
    ./rofi.nix
    ./spotify
    ./firefox
    ./obsidian.nix
    ./yazi.nix
    ./discord.nix
    ./izzy
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

    dijo
    (let
      name = "dijo";
    in
      pkgs.makeDesktopItem {
        inherit name;
        desktopName = name;
        exec = "kitty --class ${name} -e ${name}";
        icon = "calendar";
      })
  ];
}
