{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./theme
    ./theme/programs
    ./programs
  ];
}
