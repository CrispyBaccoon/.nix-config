{pkgs, ...}: {
  home.packages = [
    pkgs.stable.SDL2
    pkgs.godot
  ];
}
