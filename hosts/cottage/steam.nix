{lib, ...}: {
  apps.steam = lib.custom.use {
    enable = false;
  };
}
