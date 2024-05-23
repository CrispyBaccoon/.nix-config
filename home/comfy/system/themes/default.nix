{pkgs, lib, ...}: {
  imports = [
    ./gtk.nix
    ./qt.nix
  ];

  styles = lib.custom.use {
    fonts = {
      monospace = {
        name = "Maple Mono NF";
      };
    };
  };

  home = {
    pointerCursor = {
      package = lib.mkDefault pkgs.capitaine-cursors;
      name = lib.mkDefault "capitaine-cursors";
      size = 32;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
