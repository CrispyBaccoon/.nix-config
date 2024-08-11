{pkgs, ...}: {
  home.packages = [
    pkgs.nodejs_20
    pkgs.yarn
    pkgs.bun
    pkgs.deno
  ];
}
