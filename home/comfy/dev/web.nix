{pkgs, ...}: {
  home.packages = [
    pkgs.stable.nodejs_20
    pkgs.stable.yarn
    pkgs.bun
    pkgs.deno
  ];
}
